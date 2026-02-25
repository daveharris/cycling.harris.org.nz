import { Controller } from "@hotwired/stimulus"

// Pico CSS actual values
const YOU_COLOUR = [32, 96, 223] // --pico-color-blue-550: #2060df
const MEDIAN_COLOUR = [197, 47, 33] // --pico-color-red-550: #c52f21
const FASTEST_COLOR = [242, 223, 13] // --pico-color-yellow-100: #f2df0d

const rgba = (rgb, alpha) => `rgba(${[...rgb, alpha].join(',')})`
const toHMMSS = epoch => new Date(epoch * 1000).toISOString().slice(12, 19)
const toHMM = (epoch) => toHMMSS(epoch).slice(0, -3)
const minutes = (n) => n * 60

export default class extends Controller {
  connect() {
    const canvas = this.element
    if (!canvas) return

    const data = {
      labels: JSON.parse(canvas.dataset.date),
      datasets: [
        {
          label: "You",
          data: JSON.parse(canvas.dataset.duration),
          fill: true,
          backgroundColor: rgba(YOU_COLOUR, 0.2),
          borderColor: rgba(YOU_COLOUR, 0.8),
          pointBorderColor: rgba(YOU_COLOUR, 0.8),
          pointBackgroundColor: rgba(YOU_COLOUR, 0.8)
        },
        {
          label: "Median",
          data: JSON.parse(canvas.dataset.medianDuration),
          fill: true,
          backgroundColor: rgba(MEDIAN_COLOUR, 0.2),
          borderColor: rgba(MEDIAN_COLOUR, 0.8),
          pointBorderColor: rgba(MEDIAN_COLOUR, 0.8),
          pointBackgroundColor: rgba(MEDIAN_COLOUR, 0.8)
        },
        {
          label: "Fastest",
          data: JSON.parse(canvas.dataset.fastestDuration),
          fill: true,
          backgroundColor: rgba(FASTEST_COLOR, 0.2),
          borderColor: rgba(FASTEST_COLOR, 0.8),
          pointBorderColor: rgba(FASTEST_COLOR, 0.8),
          pointBackgroundColor: rgba(FASTEST_COLOR, 0.8)
        }
      ]
    }

    new Chart(canvas.getContext("2d"), {
      type: "line",
      data,
      options: {
        datasets: {
          line: {
            tension: 0.4 // Was the default in Chart.js v3
          }
        },
        scales: {
          y: {
            ticks: {
              stepSize: minutes(30), // interval between ticks
              callback: toHMM
            }
          }
        },
        plugins: {
          tooltip: {
            callbacks: {
              label: ctx => `${ctx.dataset.label}: ${toHMMSS(ctx.raw)}`
            }
          }
        }
      }
    })
  }
}
