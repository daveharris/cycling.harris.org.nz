class Result < ActiveRecord::Base
  belongs_to :user
  belongs_to :race

  validates :user_id, :race_id, :duration, :date, presence: true
  validates :duration, numericality: { only_integer: true, greater_than: 0 }

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

  def self.from_csv(filename, user)
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

  def self.from_strava(activity_id, race_id, user)
    @client ||= Strava::Api::V3::Client.new(access_token: '7360ac33e4acc82eb6a29f79469936eb974a4646')

    activity = @client.retrieve_an_activity(activity_id)
    
    result_details = {race_id: race_id, user: user}
    result_details[:duration] = activity['moving_time']
    result_details[:date] = Date.parse(activity['start_date'])
    result_details[:comment] = activity['description']
    result_details[:strava_url] = "http://www.strava.com/activities/#{activity_id}"

    puts "About to insert Result: #{result_details.inspect}"

    Result.create!(result_details)
  end
end
