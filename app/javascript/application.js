// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";
import "@rails/actioncable";

// Add global listener for Turbo Stream events
document.addEventListener("turbo:before-stream-render", (event) => {
  console.log("Turbo stream event detected:", event.target.action);
});

// Add scroll-to-bottom behavior for message containers
document.addEventListener("turbo:frame-load", () => {
  const messagesContainer = document.querySelector(".messages-container");
  if (messagesContainer) {
    messagesContainer.scrollTop = messagesContainer.scrollHeight;
  }
});

// Setup auto-scroll when new messages arrive
document.addEventListener("turbo:before-stream-render", (event) => {
  const action = event.target.getAttribute("action");
  const target = event.target.getAttribute("target");

  // If new message is being added
  if (
    (action === "append" || action === "prepend") &&
    target &&
    target.includes("_messages")
  ) {
    // We'll scroll after the content is rendered
    setTimeout(() => {
      const messagesContainer = document.querySelector(".messages-container");
      if (messagesContainer) {
        messagesContainer.scrollTop = messagesContainer.scrollHeight;
      }
    }, 100);
  }
});
