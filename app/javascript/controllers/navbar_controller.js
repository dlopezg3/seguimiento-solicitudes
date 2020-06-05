import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "li" ]

  toggleActiveClass() {
    this.liTargets.forEach((el, i) => {
      el.classList.toggle("active")
      localStorage.setItem("state", this.className)
    })
  }
}

