class Race < ActiveRecord::Base
  has_many :results

  validates :name, :distance, presence: true
  validates :name, uniqueness: { scope: :distance }

  default_scope { order(distance: :desc) }


  def to_s
    "#{name} (#{distance}km)"
  end
  alias_method :collection_select_name, :to_s
end
