module ApplicationHelper

  def date_in_words(date)
    date.strftime("#{date.day.ordinalize} %b %y") if date
  end

  def duration_in_words(duration)
    ChronicDuration.output(duration.abs, format: :chrono) if duration.is_a?(Fixnum)
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
      labels: data.map(&:first),
      datasets: [
        {
          label:       'My Duration',
          fillColor:   'rgba(51, 122, 183, 0.2)', # blue
          strokeColor: 'rgba(51, 122, 183, 0.6)',
          pointColor:  'rgba(51, 122, 183, 0.6)',
          data:        data.map(&:second)
        },
        {
          label:       'Fastest Duration',
          fillColor:   'rgba(96, 189, 104, 0.2)', # green
          strokeColor: 'rgba(96, 189, 104, 0.6)',
          pointColor:  'rgba(96, 189, 104, 0.6)',
          data:        data.map(&:third)
        },
        {
          label:       'Median Duration',
          fillColor:   'rgba(241, 88, 84, 0.2)', # red
          strokeColor: 'rgba(241, 88, 84, 0.6)',
          pointColor:  'rgba(241, 88, 84, 0.6)',
          data:        data.map(&:last)
        }
      ]
    }

    options = {
      responsive:           true,
      maintainAspectRatio:  false,
      scaleLabel:           %Q{<%= new Date(value*1000).toISOString().substr(11, 8) %>},
      multiTooltipTemplate: %Q{<%= datasetLabel %> <%= new Date(value*1000).toISOString().substr(11, 8) %>},
      tooltipTemplate:      %Q{<%= new Date(value*1000).toISOString().substr(11, 8) %>},
      generateLegend:       true,
      legendTemplate:       %Q{<div class="legend">
                                 <h4>Legend</h4>
                                 <h4>
                                   <% for (var i=0; i<datasets.length; i++){%>
                                     <span class="label" style="background-color:<%=datasets[i].strokeColor%>"><%=datasets[i].label%></span>
                                   <%}%>
                                 </h4>
                               </div>
                            }
    }

    line_chart(datasets, options)
  end
end
