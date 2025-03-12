class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user

  validates :content, presence: true

  after_create_commit -> {
    broadcast_append_to [room, "messages"],
    target: "#{dom_id(room)}_messages",
    partial: "messages/message",
    locals: { message: self, user_id: user_id }
  }
  after_update_commit -> { broadcast_replace_to [room, "messages"] }
  after_destroy_commit -> { broadcast_remove_to [room, "messages"] }

  private

  def dom_id(record)
    ActionView::RecordIdentifier.dom_id(record)
  end
end
