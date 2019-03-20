import { Controller } from "stimulus"
import { DirectUpload } from "@rails/activestorage"
// import Api from '../lib/api'
import Kitsu from 'kitsu'
import Mustache from 'mustache'
import Turbolinks from 'turbolinks'
import dragula from 'dragula'

const api = new Kitsu({
  baseURL: '/api/v1'
})

export default class extends Controller {
  static targets = [
    'input',
    'mediaIdsInput',
    'imagesContainer',
    'imageTemplate'
  ]

  connect() {
    this._fetchInitialMedia()
    this._setupDragula()
  }

  upload() {
    Array.from(this.inputTarget.files).forEach(file => this._doUpload(file))

    // clear the input
    this.inputTarget.value = null
  }

  removeImage (e) {
    e.preventDefault()

    let childs = Array.from(this.imagesContainerTarget.childNodes)
    let image = childs.find((child) => {
      return child.getAttribute('data-id') == e.currentTarget.getAttribute('data-id')
    })

    if (!image) return false

    image.remove()
    this._refreshMediaIds()
  }

  _addImageToList (data = {}) {
    let newImage = document.createElement('div')
    newImage.innerHTML = Mustache.render(this.imageTemplateTarget.innerHTML, data)
    this.imagesContainerTarget.appendChild(newImage.children[0])
  }

  _renderMedia () {
    this.imagesContainerTarget.innerHTML = ''
    this.mediaData.forEach((media) => { this._addImageToList(media) })
  }

  _refreshMediaIds () {
    this.mediaIds = this.mediaData.map((m) => parseInt(m.id))
  }

  _doUpload(file) {
    const upload = new DirectUpload(file, this.uploadUrl)

    this._showUploadProgress()

    upload.create((error, blob) => {
      this._hideUploadProgress()

      if (error) {
        alert('Something went wrong')
      } else {
        let req = api.get(`media/${blob.id}`)
        req.then((resp) => {
          let mediaData = this.mediaData
          mediaData.push(resp.data)
          this.mediaData = mediaData
          this._renderMedia()
          this._refreshMediaIds()
        })
      }
    })
  }

  _showUploadProgress () {
    Turbolinks.controller.adapter.progressBar.setValue(0.8)
    Turbolinks.controller.adapter.progressBar.show()
  }

  _hideUploadProgress() {
    Turbolinks.controller.adapter.progressBar.setValue(0)
    Turbolinks.controller.adapter.progressBar.hide()
  }

  _fetchInitialMedia () {
    let req = api.get('media', {
      sort: 'position',
      filter: { id: this.mediaIds.join(',') }
    })

    req.then((resp) => {
      this.mediaData = resp.data
      this._renderMedia()
    })
  }

  _setupDragula () {
    this.drake = dragula({
      containers: [this.imagesContainerTarget],
      mirrorContainer: this.imagesContainerTarget,
    })

    this.drake.on('drop', () => {
      setTimeout(() => {
        this._refreshMediaIds()
      }, 150)
    })
  }

  // Iterates through images and sets mediaIds input with their ids inproper
  // order
  _refreshMediaIds () {
    let childs = Array.from(this.imagesContainerTarget.childNodes)
    let ids = childs.map((child) => {
      return child.getAttribute('data-id')
    })

    this.mediaIds = ids
  }

  get mediaIds () {
    return JSON.parse(this.data.get('media-ids'))
  }

  get mediaData () {
    return JSON.parse(this.data.get('media'))
  }

  get uploadUrl () {
    return this.data.get('upload-url')
  }

  set mediaIds (ids) {
    this.data.set('media-ids', JSON.stringify(ids))
    this.mediaIdsInputTarget.value = ids.join(',')
  }

  set mediaData (data) {
    this.data.set('media', JSON.stringify(data))
  }
}
