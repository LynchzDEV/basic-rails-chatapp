import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["messages", "input"];

  connect() {
    this.scrollToBottom();
    this.focusInput();
  }

  scrollToBottom() {
    const messages = this.messagesTarget;
    messages.scrollTop = messages.scrollHeight;
  }

  focusInput() {
    this.inputTarget.focus();
  }

  reset() {
    this.element.reset();
    this.focusInput();
  }
}
