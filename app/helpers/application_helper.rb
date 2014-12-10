module ApplicationHelper

  def date_in_words(date)
    date.strftime("#{date.day.ordinalize} %b %y")
  end

  def duration_in_words(duration)
    ChronicDuration.output(duration.abs, format: :chrono)
  end

  def previous_time_difference(result)
    previous = result.find_previous_result
    difference = previous.duration - result.duration if previous

    if previous.nil?
      icon('ban', "First Result")
    elsif difference > 0
      icon('arrow-circle-o-up', "#{duration_in_words(difference)} faster than last time")
    else
      icon('arrow-circle-o-down', "#{duration_in_words(difference)} slower than last time")
    end

  end

  def personal_best_time_difference(result)
    pb = result.find_personal_best

    if pb
      difference = pb.duration - result.duration

      if difference == 0
        icon('check', "Personal Best")
      else
        icon('arrow-circle-o-down', "#{duration_in_words(difference)} slower than Personal Best")
      end
    end

  end
end
