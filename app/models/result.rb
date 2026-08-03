class Result < ApplicationRecord
  include Duration

  scope :in_year, ->(dt) { where(date: dt.all_year) }
  scope :rider, ->(r) { where(user_id: r) }
  scope :date_desc, -> { order(date: :desc) }
  scope :date_asc, -> { order(date: :asc) }

  belongs_to :user
  belongs_to :race

  validates :date, presence: true
  validates :duration, numericality: {only_integer: true, greater_than: 0}
  validates :fastest_duration, :median_duration, numericality: {only_integer: true, greater_than: 0}, allow_blank: true
  validates :user_id, uniqueness: {
    scope: :race_id,
    conditions: ->(record) {
      where(date: record.date.all_year)
    },
    message: ->(record, _) {
      "has already recorded a result for #{record.race} in #{record.date&.year}"
    }
  }, if: -> { race_id && user_id && date.present? }

  private

  def attributes_for_inspect
    %w[id user_id date duration]
  end
end
