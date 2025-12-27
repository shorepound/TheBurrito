import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {}

  connect() {
    this.wireCounts()
  }

  selectAll(event) {
    const group = this._groupFromElement(event.currentTarget)
    this._setGroup(group, true)
  }

  clearGroup(event) {
    const group = this._groupFromElement(event.currentTarget)
    this._setGroup(group, false)
  }

  _groupFromElement(el) {
    return el.dataset.burritoFormGroupValue || el.getAttribute('data-group')
  }

  _setGroup(groupId, checked) {
    const container = this.element.querySelector('#' + groupId)
    if (!container) return
    const cb = container.querySelectorAll('input[type=checkbox]')
    cb.forEach(c => { c.checked = checked })
    this._updateCount(groupId)
  }

  _updateCount(groupId) {
    const container = this.element.querySelector('#' + groupId)
    if (!container) return
    const cb = container.querySelectorAll('input[type=checkbox]')
    const count = Array.from(cb).filter(c => c.checked).length
    const el = document.getElementById(groupId + '-count')
    if (el) el.textContent = count
  }

  wireCounts() {
    ['fillings-group', 'toppings-group'].forEach(id => {
      const container = this.element.querySelector('#' + id)
      if (!container) return
      this._updateCount(id)
      const cb = container.querySelectorAll('input[type=checkbox]')
      cb.forEach(c => c.addEventListener('change', () => this._updateCount(id)))
    })
  }
}
