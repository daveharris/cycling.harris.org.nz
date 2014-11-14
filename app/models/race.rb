class Race < ActiveRecord::Base
  has_many :results

  validates :name, :distance, presence: true
  validates :name, uniqueness: { scope: :distance }
end
