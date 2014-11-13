class Result < ActiveRecord::Base
  belongs_to :user
  belongs_to :race

  validates :user_id, :race_id, :duration, :date, presence: true

  default_scope { order(date: :desc) }

  def find_previous_result
    Result.where.not(id: self.id)
          .where(race: self.race)
          .where('date < ?', self.date)
          .order(date: :desc)
          .first
  end

  def time_difference_between_previous
    if previous = find_previous_result
      previous.duration - self.duration
    end
  end
end
