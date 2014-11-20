class Race < ActiveRecord::Base
  has_many :results

  validates :name, :distance, presence: true
  validates :name, uniqueness: { scope: :distance }

  def collection_select_name
    "#{name} (#{distance}km)"
  end
end
