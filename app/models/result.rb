require 'open-uri'

class Result < ActiveRecord::Base
  belongs_to :user
  belongs_to :race

  validates :user_id, :race_id, :duration, :date, presence: true
  validates :duration, numericality: { only_integer: true, greater_than: 0 }

  default_scope { order(date: :desc) }

  def date_for_form
    read_attribute(:date).try(:strftime, '%-d %b %Y')
  end

  def find_previous_result
    Result.where(race: self.race)
          .where('date < ?', self.date)
          .first
  end

  def find_personal_best
    Result.unscoped
          .where(race: self.race)
          .order({duration: :asc, date: :desc})
          .first
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
    unless activity_id.match(/^\d+$/)
      if activity_id.match(/http:\/\/www.strava.com\/activities\/(\d+)/)
        activity_id = $1
      else
        return nil
      end
    end

    client = Strava::Api::V3::Client.new(access_token: '7360ac33e4acc82eb6a29f79469936eb974a4646')

    activity = client.retrieve_an_activity(activity_id)
    
    result_details = {race_id: race_id, user: user}
    result_details[:duration] = activity['moving_time']
    result_details[:date] = Date.parse(activity['start_date_local'])
    result_details[:comment] = activity['description']
    result_details[:strava_url] = "http://www.strava.com/activities/#{activity_id}"

    Result.create!(result_details)
  end

  def self.from_timing_team(url, race_id, user)
    doc = Nokogiri::HTML(open(url))

    all_results_url = "#{url}&cell=start"
    all_results_doc = Nokogiri::HTML(open(all_results_url))
    
    result_details = {race_id: race_id, user: user}
    result_details[:duration] = ChronicDuration.parse(doc.css('font.participant_time').text)
    result_details[:date] = Date.parse(doc.css('font.event_date').children.first.text)
    result_details[:wind] = doc.css('td[background="dmapps/images/wind.png"]').text.split(' ').last
    result_details[:position], result_details[:finishers] = doc.css('.participant_details')[2].text.scan(/\d+/)
    result_details[:timing_url] = url

    fastest, median, slowest = all_results_doc.at_css('.mat_time').text.split('|').map(&:squish)
    result_details[:fastest_duration] = ChronicDuration.parse(fastest.split('Time:').last)
    result_details[:mean_duration] = ChronicDuration.parse(median.split('Time:').last)

    Result.create!(result_details)
  end
end
