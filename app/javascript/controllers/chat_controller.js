import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["messages", "input"];

  connect() {
    console.log("Chat controller connected");
    this.scrollToBottom();
    this.setupTurboStreamEvents();
  }

  setupTurboStreamEvents() {
    console.log("Setting up Turbo Stream events");

    document.addEventListener("turbo:before-stream-render", (event) => {
      if (
        event.target &&
        event.target.target &&
        event.target.target.includes("_messages")
      ) {
        console.log("Message stream about to render");
      }
    });

    document.addEventListener("turbo:stream-render", (event) => {
      if (
        event.target &&
        event.target.target &&
        event.target.target.includes("_messages")
      ) {
        console.log("Message stream rendered, scrolling to bottom");
        this.scrollToBottom();
      }
    });

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
