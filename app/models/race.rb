class Race < ActiveRecord::Base
  has_many :results

  validates :name, :distance, presence: true
  validates :name, uniqueness: { scope: :distance }

  default_scope { order(distance: :desc) }

  def collection_select_name
    "#{name} (#{distance}km)"
  end
end
