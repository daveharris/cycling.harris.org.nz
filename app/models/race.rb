class Race < ActiveRecord::Base
  extend FriendlyId

  has_many :results

  validates :name, :distance, presence: true
  validates :name, uniqueness: { scope: :distance, message: "and Distance combination already exists" }

  friendly_id :slug_candidates

  default_scope { order(distance: :desc) }

  def slug_candidates
    [
      :name,
      [:name, :distance]
    ]
  end

  def should_generate_new_friendly_id?
    true
  end

  def to_s
    "#{name} (#{distance}km)"
  end
  alias_method :collection_select_name, :to_s

  def result_duration_over_time
    chartjs_data_helper(results.order(:date), [:date, :duration, :fastest_duration, :median_duration])
  end

  # Returns structured hash in a format easily readable for Chart.js
  # Transforms date fields into strings for JSON parsing
  # chartjs_data_helper(results.order(:date), [:date, :duration])
  # => { date: ["24 Nov 2012", "30 Nov 2013", "29 Nov 2014"],
  #      duration: [20047, 20189, 18757]
  #    }
  def chartjs_data_helper(relation, keys)
    transposed_data = relation.pluck(*keys).transpose
    chart_data = Hash[keys.zip(transposed_data)]
    chart_data[:date] = chart_data[:date].map{|d| d.strftime('%-d %b %Y')} if keys.include?(:date)
    chart_data
  end
end
