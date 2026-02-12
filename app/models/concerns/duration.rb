module Duration
  extend ActiveSupport::Concern

  H_MM_SS_FORMAT = /\A\d:\d{2}:\d{2}\z/

  included do
    validates :duration_s,
      format: {with: H_MM_SS_FORMAT, message: "is not in the format 'h:mm:ss'"}
    validates :fastest_duration_s, :median_duration_s,
      format: {with: H_MM_SS_FORMAT, message: "is not in the format 'h:mm:ss'"}, allow_blank: true
  end

  def duration_s
    Result.to_duration(duration) if duration
  end

  def fastest_duration_s
    Result.to_duration(fastest_duration) if fastest_duration
  end

  def median_duration_s
    Result.to_duration(median_duration) if median_duration
  end

  def duration_s=(value)
    self.duration = Result.parse_duration(value.to_s)
  end

  def fastest_duration_s=(value)
    self.fastest_duration = Result.parse_duration(value.to_s)
  end

  def median_duration_s=(value)
    self.median_duration = Result.parse_duration(value.to_s)
  end

  class_methods do
    def parse_duration(h_mm_ss)
      (Time.strptime(h_mm_ss, "%H:%M:%S") - Time.parse("00:00:00")).to_i
    end

    def to_duration(seconds)
      Time.at(seconds).utc.strftime("%-H:%M:%S")
    end
  end
end
