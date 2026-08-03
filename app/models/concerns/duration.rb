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
    Result.to_clock_time(duration) if duration
  end

  def fastest_duration_s
    Result.to_clock_time(fastest_duration) if fastest_duration
  end

  def median_duration_s
    Result.to_clock_time(median_duration) if median_duration
  end

  def duration_s=(h_mm_ss)
    self.duration = Result.parse_clock_time(h_mm_ss)
  end

  def fastest_duration_s=(h_mm_ss)
    self.fastest_duration = Result.parse_clock_time(h_mm_ss)
  end

  def median_duration_s=(h_mm_ss)
    self.median_duration = Result.parse_clock_time(h_mm_ss)
  end

  class_methods do
    def parse_clock_time(h_mm_ss)
      unless H_MM_SS_FORMAT.match?(h_mm_ss)
        raise ArgumentError, "Invalid format. #{h_mm_ss.inspect} must match H:MM:SS"
      end

      hours, minutes, seconds = h_mm_ss.split(":").map(&:to_i)
      (hours.hours + minutes.minutes + seconds.seconds).to_i
    end

    def to_clock_time(int)
      hours = int / 3600
      minutes = (int % 3600) / 60
      secs = int % 60

      format("%d:%02d:%02d", hours, minutes, secs)
    end
  end
end
