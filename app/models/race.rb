class Race < ActiveRecord::Base
  extend FriendlyId

  has_many :results

  validates :name, :distance, presence: true
  validates :name, uniqueness: { scope: :distance }

  friendly_id :slug_candidates

  default_scope { order(distance: :desc) }

  def slug_candidates
    [
      :name,
      [:name, :distance]
    ]
  end

  def to_s
    "#{name} (#{distance}km)"
  end
  alias_method :collection_select_name, :to_s

  def result_duration_over_time
    results.order(:date).pluck(:date, :duration, :fastest_duration, :median_duration).each do |array|
      array[0] = array[0].strftime('%-d %b %Y')
    end
  end
end
