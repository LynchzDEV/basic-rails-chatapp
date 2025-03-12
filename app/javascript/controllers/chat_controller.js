// app/javascript/controllers/chat_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["messages", "input"];

  connect() {
    console.log("Chat controller connected", this.messagesTarget);
    console.log("Messages container ID:", this.messagesTarget.id);
    this.scrollToBottom();
    this.setupTurboStreamEvents();
  }

  setupTurboStreamEvents() {
    console.log("Setting up Turbo Stream events");

    document.addEventListener("turbo:before-stream-render", (event) => {
      console.log("Turbo stream before render:", event.target);
    });

    document.addEventListener("turbo:stream-render", (event) => {
      console.log("Turbo stream rendered:", event.target);
      this.scrollToBottom();
    });

    // Listen for ActionCable connections/disconnections
    document.addEventListener("turbo:connected", () => {
      console.log("Turbo connected to server");
    });

    document.addEventListener("turbo:disconnected", () => {
      console.log("Turbo disconnected from server");
    });
  }

  scrollToBottom() {
    const messagesContainer = this.messagesTarget;
    if (messagesContainer) {
      messagesContainer.scrollTop = messagesContainer.scrollHeight;
      console.log("Scrolled to bottom");
    }
  }

  resetForm(event) {
    event.target.reset();
    this.inputTarget.focus();
  }
}
