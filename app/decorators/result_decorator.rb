class ResultDecorator < Draper::Decorator
  include Draper::LazyHelpers
  delegate_all

  def previous_time_difference(attribute)
    previous = find_previous_result

    if previous && (previous_attribute = previous.public_send(attribute)) && (current_attribute = result.public_send(attribute))
      difference = previous_attribute - current_attribute

      if difference > 0
        "#{duration_in_words(difference)} #{icon('arrow-circle-o-up')} than previous".html_safe
      else
        "#{duration_in_words(difference)} #{icon('arrow-circle-o-down')} than previous".html_safe
      end
    else
      "1st Result"
    end
  end

  def wind_speed_icon
    icon(:flag, "#{wind} km/h") if wind.present?
  end

  def fastest_duration_icon
    if result.fastest_duration
      [ icon('trophy'),
        icon('clock-o', duration_in_words(result.fastest_duration)),
        "(#{previous_time_difference(:fastest_duration)})",
      ].join(' ').html_safe
    end
  end

  def median_duration_icon
    if result.median_duration
      [ 'σ',
        icon('clock-o', duration_in_words(result.median_duration)),
        "(#{previous_time_difference(:median_duration)})",
      ].join(' ').html_safe
    end
  end

  def position_icon
    icon('flag-checkered', "#{position.to_i.ordinalize} / #{finishers}") if position.present? && position > 0
  end

  def link_icon(name, location)
    icon(:link, link_to(name, location)).html_safe if location.present?
  end

  def year
    self.date.try(:year)
  end

end
