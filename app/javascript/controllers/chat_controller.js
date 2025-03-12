import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["messages", "input"];

  connect() {
    console.log("Chat controller connected");
    this.scrollToBottom();
    this.setupTurboStreamEvents();
  }

  scrollToBottom() {
    const messagesContainer = this.messagesTarget;
    if (messagesContainer) {
      messagesContainer.scrollTop = messagesContainer.scrollHeight;
    }
  }

  setupTurboStreamEvents() {
    document.addEventListener("turbo:before-stream-render", (event) => {
      if (event.target && event.target.action === "append") {
        this.scrollToBottom();
      }
    });
  }

  resetForm(event) {
    event.target.reset();
    this.inputTarget.focus();
  }
}
