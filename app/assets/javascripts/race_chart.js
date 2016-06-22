$(document).on('ready page:load', function () {
  var resultDurationCanvas = $("canvas#result_duration_over_time_chart");

  if (resultDurationCanvas.length != 1) {
    return
  }

  new Chart(resultDurationCanvas, {
    type: 'line',
    data: {
      labels: resultDurationCanvas.data('date'),
      datasets: [{
        label:                'Me',
        fill:                 true,
        backgroundColor:      'rgba(31, 50, 173, 0.2)', // blue
        borderColor:          'rgba(31, 50, 173, 0.6)',
        pointBorderColor:     'rgba(31, 50, 173, 0.6)',
        pointBackgroundColor: 'rgba(31, 50, 173, 0.6)',
        data: resultDurationCanvas.data('duration')
      }, {
        label:                'Fastest',
        fill:                 true,
        backgroundColor:      'rgba(173, 31, 50, 0.2)',  // red
        borderColor:          'rgba(173, 31, 50, 0.6)',
        pointBorderColor:     'rgba(173, 31, 50, 0.6)',
        pointBackgroundColor: 'rgba(173, 31, 50, 0.6)',
        data: resultDurationCanvas.data('fastest-duration')
      }, {
        label:                'Median',
        fill:                 true,
        backgroundColor:      'rgba(173, 154, 31, 0.2)', // orange
        borderColor:          'rgba(173, 154, 31, 0.6)',
        pointBorderColor:     'rgba(173, 154, 31, 0.6)',
        pointBackgroundColr:  'rgba(173, 154, 31, 0.6)',
        data: resultDurationCanvas.data('median-duration')
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      scales: {
        yAxes: [{
          ticks: {
            userCallback: function(v) { return epoch_to_hh_mm_ss(v) },
            stepSize: 30 * 60
          }
        }]
      },
      tooltips: {
        callbacks: {
          label: function(tooltipItem, data) {
            return data.datasets[tooltipItem.datasetIndex].label + ': ' + epoch_to_hh_mm_ss(tooltipItem.yLabel)
          }
        }
      }
    }
  });

  function epoch_to_hh_mm_ss(epoch) {
    return new Date(epoch*1000).toISOString().substr(12, 7)
  }
});