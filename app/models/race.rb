class Race < ApplicationRecord

  scope :alphabetical, -> { order(name: :asc, distance: :asc) }

  validates :name, :distance, presence: true
  validates :name, uniqueness: { scope: :distance, message: "and Distance combination already exists" }

  def to_s
    "#{name} (#{distance}km)"
  end

end
