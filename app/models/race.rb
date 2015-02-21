class Race < ActiveRecord::Base
  has_many :results

  validates :name, :distance, presence: true
  validates :name, uniqueness: { scope: :distance }

  default_scope { order(distance: :desc) }

  def to_s
    "#{name} (#{distance}km)"
  end
  alias_method :collection_select_name, :to_s

  def result_duration_over_time
    Hash[results.pluck(:date, :duration)]
  end
end
