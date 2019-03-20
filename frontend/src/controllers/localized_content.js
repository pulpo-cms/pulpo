import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [
    'segment',
    'currentLocale',
    'switch'
  ]

  connect () {
    // Refresh state
    this.currentLocaleCode = this.currentLocaleCode
  }

  showSegment (e) {
    this.currentLocaleCode = e.target.dataset.showSegmentLocale
  }

  _updateSegmentsVisibility () {
    this.segmentTargets.forEach((el) => {
      if (el.dataset.localeCode == this.currentLocale.code) {
        el.classList.remove("d-none")
      } else {
        el.classList.add("d-none")
      }
    })
  }

  _findLocale (code) {
    return this.locales.find((l) => { return l.code == code })
  }

  _updateCurrentLocaleInView () {
    this.currentLocaleTarget.text = this.currentLocale.name
  }

  get currentLocale () {
    return this._findLocale(this.currentLocaleCode)
  }

  get currentLocaleCode () {
    return this.data.get('current-locale-code')
  }

  get locales () {
    return this.switchTargets.map((el) => {
      return {
        code: el.dataset.showSegmentLocale,
        name: el.text,
      }
    })
  }

  set currentLocaleCode (val) {
    this.data.set('current-locale-code', val)
    this._updateCurrentLocaleInView()
    this._updateSegmentsVisibility()
  }
}
