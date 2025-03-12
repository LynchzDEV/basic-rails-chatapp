// app/javascript/controllers/chat_controller.js
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
      console.log("Scrolled to bottom");
    }
  }

  setupTurboStreamEvents() {
    document.addEventListener("turbo:before-stream-render", (event) => {
      // Debug info to console
      console.log("Turbo stream event:", event.target);

      // Wait for the DOM update to complete before scrolling
      if (event.target && event.target.action === "append") {
        setTimeout(() => this.scrollToBottom(), 50);
      }
    });
  }

  resetForm(event) {
    event.target.reset();
    this.inputTarget.focus();
    // Add a delay before scrolling again to ensure DOM is updated
    setTimeout(() => this.scrollToBottom(), 50);
  }
}
