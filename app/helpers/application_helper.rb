module ApplicationHelper

  def date_in_words(date)
    date.strftime("#{date.day.ordinalize} %b %y") if date
  end

  def duration_in_words(duration)
    ChronicDuration.output(duration.abs, format: :chrono) if duration
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

  def graph(data)
    datasets = {
      labels: data.keys,
      datasets: [
        {
          fillColor:            "rgba(151,187,205,0.2)",
          strokeColor:          "rgba(151,187,205,1)",
          pointColor:           "rgba(151,187,205,1)",
          pointStrokeColor:     "#fff",
          pointHighlightFill:   "#fff",
          pointHighlightStroke: "rgba(151,187,205,1)",
          data:                 data.values
        }
      ]
    }

    options = {
      width:           '1140px',
      scaleLabel:      %Q{<%= new Date(value*1000).toISOString().substr(11, 8) %>},
      tooltipTemplate: %Q{<%= new Date(value*1000).toISOString().substr(11, 8) %>},
    }

    line_chart(datasets, options)
  end
end
