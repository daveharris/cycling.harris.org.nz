module RaceHelper

  def race_graph(data)
    return if data.empty?

    min, max = data.flatten.keep_if{|v| v.is_a?(Fixnum)}.minmax
    step_width = 1800
    bottom = ((min - step_width) / 3600) * 3600 # To ensure it's a round time (:00)
    top = max + (2*step_width)
    steps = (top - bottom)/step_width

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
      scaleOverride: true,
      scaleSteps: steps,
      scaleStepWidth: step_width,
      scaleStartValue: bottom,

      responsive:           true,
      maintainAspectRatio:  false,
      scaleLabel:           %Q{<%= new Date(value*1000).toISOString().substr(12, 7) %>},
      multiTooltipTemplate: %Q{<%= datasetLabel %> <%= new Date(value*1000).toISOString().substr(12, 7) %>},
      tooltipTemplate:      %Q{<%= new Date(value*1000).toISOString().substr(12, 7) %>},
      generateLegend:       true,
      legendTemplate:       %Q{<div class="legend">
                                 <h4>Legend</h4>
                                 <h4 class="labels">
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
