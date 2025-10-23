class Result < ApplicationRecord
  belongs_to :user
  belongs_to :race

  validates :date, presence: true
  validates :duration, numericality: {only_integer: true, greater_than: 0}

  private

  def attributes_for_inspect
    %w[id user_id date duration]
  end
end
