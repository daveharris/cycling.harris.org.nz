module ApplicationHelper

  def duration_in_words(duration, format: :chrono)
    ChronicDuration.output(duration.abs, format: format, limit_to_hours: true) if duration.is_a?(Fixnum)
  end

  def personal_best_time_difference(result)
    pb = result.find_personal_best

    if pb
      difference = pb.duration - result.duration

      if difference == 0
        icon('check', "Personal Best")
      else
        "#{duration_in_words(difference)} #{icon('arrow-circle-o-down')} than Personal Best".html_safe
      end
    end

  end
end
