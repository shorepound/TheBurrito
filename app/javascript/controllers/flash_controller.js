import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { timeout: { type: Number, default: 5000 } }

  connect() {
    this._timeouts = []
    const alerts = Array.from(this.element.querySelectorAll('.alert'))
    alerts.forEach(alert => {
      // Ensure fade/show classes for Bootstrap transition
      alert.classList.add('fade', 'show')

      const t = setTimeout(() => {
        // start hide transition
        alert.classList.remove('show')

        // remove element after transition completes (or fallback)
        const remove = () => { if (alert.parentNode) alert.parentNode.removeChild(alert) }
        alert.addEventListener('transitionend', remove, { once: true })
        setTimeout(remove, 700)
      }, this.timeoutValue)

      this._timeouts.push(t)
    })
  }

  disconnect() {
    (this._timeouts || []).forEach(t => clearTimeout(t))
    this._timeouts = []
  }
}
