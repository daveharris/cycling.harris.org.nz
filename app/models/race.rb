class Race < ApplicationRecord
  scope :alphabetical, -> { order(name: :asc, distance: :asc) }

  validates :name, presence: true
  validates :name, uniqueness: {scope: :distance, message: "and Distance combination already exists"}
  validates :distance, {numericality: {integer_only: true, greater_than_zero: true}}

  def to_s
    "#{name} (#{distance}km)"
  end

  private

  def attributes_for_inspect
    %w[id name distance]
  end
end
