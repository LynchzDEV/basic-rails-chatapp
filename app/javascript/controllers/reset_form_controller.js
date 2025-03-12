import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.scrollToBottom();
  }

  reset() {
    this.element.reset();
    this.scrollToBottom();
  }

  scrollToBottom() {
    const messagesContainer = document.querySelector(".messages-container");
    if (messagesContainer) {
      setTimeout(() => {
        messagesContainer.scrollTop = messagesContainer.scrollHeight;
      }, 100);
    }
  }
}
