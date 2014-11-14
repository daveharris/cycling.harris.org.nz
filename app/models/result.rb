class Result < ActiveRecord::Base
  belongs_to :user
  belongs_to :race

  validates :user_id, :race_id, :duration, :date, presence: true

  default_scope { order(date: :desc) }

  def find_previous_result
    Result.where(race: self.race)
          .where('date < ?', self.date)
          .order(date: :desc)
          .first
  end

  def time_difference_between_previous
    if previous = find_previous_result
      previous.duration - self.duration
    end
  end

  def self.import(filename, user)
    SmarterCSV.process(filename) do |row|
      race_details = row.first
      race_details.delete(:difference)
      
      race = Race.find_or_create_by!(name: race_details.delete(:race), distance: race_details.delete(:distance))
      race_details[:race] = race

      race_details[:duration] = ChronicDuration.parse(race_details[:duration])
      race_details[:user] = user

      Result.create!(race_details)
    end
  end
end
