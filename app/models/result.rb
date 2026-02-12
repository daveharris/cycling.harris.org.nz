class Result < ApplicationRecord
  include Duration

  belongs_to :user
  belongs_to :race

  validates :date, presence: true
  validates :duration, numericality: {only_integer: true, greater_than: 0}
  validates :fastest_duration, :median_duration, numericality: {only_integer: true, greater_than: 0}, allow_blank: true

  private

  def attributes_for_inspect
    %w[id user_id date duration]
  end
end
