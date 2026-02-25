class Race < ApplicationRecord
  scope :alphabetical, -> { order(name: :asc, distance: :asc) }

  has_many :results

  validates :name, presence: true
  validates :name, uniqueness: {scope: :distance, message: "and Distance combination already exists"}
  validates :distance, {numericality: {integer_only: true, greater_than_zero: true}}

  def result_duration_over_time(rider)
    chartjs_data_helper(
      results.rider(rider).date_asc,
      [:date, :duration, :fastest_duration, :median_duration]
    )
  end

  def to_param
    "#{name.parameterize}-#{distance}"
  end

  def to_s
    "#{name} (#{distance}km)"
  end

  def self.find_by_slug!(slug)
    name_slug, _, distance = slug.rpartition("-")

    where(distance:)
      .find { |r| r.name.parameterize == name_slug } ||
      raise(ActiveRecord::RecordNotFound)
  end

  private

  # Returns structured hash in a format easily readable for Chart.js
  # Transforms date fields into strings for JSON parsing
  #
  # chartjs_data_helper(results.order(:date), [:date, :duration])
  # => { date:     ["24 Nov 2012", "30 Nov 2013", "29 Nov 2014"],
  #      duration: [20047,         20189,         18757        ]
  #    }
  def chartjs_data_helper(relation, keys)
    data_by_column = relation.pluck(keys).transpose
    chart_data = keys.zip(data_by_column).to_h

    if chart_data.key?(:date)
      chart_data[:date] = chart_data[:date].map(&:year)
    end

    chart_data
  end

  def attributes_for_inspect
    %w[id name distance]
  end
end
