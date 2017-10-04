require 'open-uri'

class Result < ActiveRecord::Base
  extend FriendlyId

  DURATION_FIELDS = [:duration, :fastest_duration, :median_duration]

  belongs_to :user
  belongs_to :race

  validates :user_id, :race_id, :date, :duration_s, presence: true
  validate  :unique_within_race_and_year

  friendly_id :race_date

  scope :date_desc, -> { order(date: :desc) }
  scope :date_asc,  -> { order(date: :asc) }
  scope :in_year,   ->(date) { where(date: date.beginning_of_year..date.end_of_year) }
  scope :rider,     ->(user) { where(user: user) }

  DURATION_FIELDS.each do |field|
    field_s = "#{field}_s"
    attr_accessor field_s

    validates field_s,
              format: { with: /\A\d{1,2}:\d{2}:\d{2}\z/, message: "is not in the format 'h[h]:mm:ss'" },
              allow_nil: true, allow_blank: true

    define_method("#{field_s}=") do |value|
      self[field] = ChronicDuration.parse(value.to_s)
    end

    define_method(field_s) do
      ChronicDuration.output(self[field].abs, format: :chrono) if self[field].present?
    end
  end

  def name
    "#{self.date.try(:year)} #{self.race.try(:name)}"
  end

  def race_date
    "#{self.race.try(:slug)}-#{self.date.try(:year)}"
  end

  def should_generate_new_friendly_id?
    true
  end

  def date_for_form
    read_attribute(:date).try(:strftime, '%-d %b %Y')
  end

  def find_previous_result
    Result.rider(self.user)
          .where(race: self.race)
          .where('date < ?', self.date)
          .date_desc
          .first
  end

  def find_personal_best
    Result.rider(self.user)
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
      if activity_id.match(/activities\/(\d+)/)
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
    result_details[:strava_url] = "https://www.strava.com/activities/#{activity_id}"

    Result.create!(result_details)
  end

  def self.from_timing_team(url, race_id, user)
    result = Result.new({timing_url: url, race_id: race_id, user: user})

    result.enrich_from_timing_team
    result
  end

  def enrich_from_timing_team
    doc = Nokogiri::HTML(open(self.timing_url))

    all_results_url = "#{self.timing_url}&cell=start"
    all_results_doc = Nokogiri::HTML(open(all_results_url))

    result_details = {}
    result_details[:duration] = ChronicDuration.parse(doc.css('font.participant_time').text)
    result_details[:date] = Date.parse(doc.css('font.event_date').children.first.text) if doc.css('font.event_date').present?
    result_details[:wind] = doc.css('td[background="dmapps/images/wind.png"]').text.split(' ').last
    result_details[:position], result_details[:finishers] = doc.css('.participant_details')[2].text.scan(/\d+/)

    fastest, median, _slowest = all_results_doc.at_css('.mat_time').text.split('|').map(&:squish)
    result_details[:fastest_duration] = ChronicDuration.parse(fastest.split('Time:').last)
    result_details[:median_duration] = ChronicDuration.parse(median.split('Time:').last)

    self.update!(result_details)
  end

  private

  def unique_within_race_and_year
    if self.race.present? &&
       self.date.present? &&
       self.user.present? &&
       Result.rider(self.user)
             .in_year(self.date)
             .where(race: self.race)
             .where.not(id: self.id)
             .exists?

      errors.add(:base, "A Result by #{self.user.to_s} for #{self.race.name} in #{self.date.year} already exists")
    end
  end

end
