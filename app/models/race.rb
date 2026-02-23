class Race < ApplicationRecord
  scope :alphabetical, -> { order(name: :asc, distance: :asc) }

  validates :name, presence: true
  validates :name, uniqueness: {scope: :distance, message: "and Distance combination already exists"}
  validates :distance, {numericality: {integer_only: true, greater_than_zero: true}}

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

  def attributes_for_inspect
    %w[id name distance]
  end
end
