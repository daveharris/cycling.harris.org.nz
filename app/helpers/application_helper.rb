module ApplicationHelper

  def date_in_words(date)
    date.strftime("#{date.day.ordinalize} %b %y")
  end

  def duration_in_words(duration)
    ChronicDuration.output(duration, format: :chrono)
  end

  def display_time_difference_in_words(difference)
    time = ChronicDuration.output(difference.abs, format: :chrono) rescue nil

    if difference.nil?
      icon('ban', "First Result")
    elsif difference > 0
      icon('arrow-circle-o-up', "#{time} faster than last time")
    else
      icon('arrow-circle-o-down', "#{time} slower than last time")
    end
  end
end
