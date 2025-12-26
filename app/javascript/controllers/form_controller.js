import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  submit(event) {
    const button = event.target.querySelector('[type="submit"]')
    if (button) {
      button.disabled = true
      button.dataset.originalText = button.textContent
      button.textContent = "Saving…"
    }
  }
}
