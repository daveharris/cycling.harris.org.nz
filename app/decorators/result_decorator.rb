class ResultDecorator < Draper::Decorator
  include Draper::LazyHelpers
  delegate_all

  def previous_time_difference(attribute)
    previous = find_previous_result

    if previous && (previous_attribute = previous.public_send(attribute)) && (current_attribute = result.public_send(attribute))
      difference = previous_attribute - current_attribute

      direction = difference > 0 ? 'arrow-graph-up-right' : 'arrow-graph-down-right'
      "#{duration_in_words(difference)} #{ion_icon(direction, text: 'than previous')}".html_safe
    else
      "1st Result"
    end
  end

  def wind_speed_icon
    ion_icon(:flag, text: "#{wind} km/h") if wind.present?
  end

  def fastest_duration_icon
    if result.fastest_duration
      [ ion_icon('ribbon-a'),
        ion_icon('ios-stopwatch-outline', text: duration_in_words(result.fastest_duration)),
        "(#{previous_time_difference(:fastest_duration)})",
      ].join(' ').html_safe
    end
  end

  def median_duration_icon
    if result.median_duration
      [ 'σ',
        ion_icon('ios-stopwatch-outline', text: duration_in_words(result.median_duration)),
        "(#{previous_time_difference(:median_duration)})"
      ].join(' ').html_safe
    end
  end

  def position_icon
    ion_icon('ios-people', text: "#{position.to_i.ordinalize} / #{finishers}") if position.present? && position > 0
  end

  def link_icon(name, location)
    ion_icon(:link, text: link_to(name, location)) if location.present?
  end

  def year
    self.date.try(:year)
  end

end
