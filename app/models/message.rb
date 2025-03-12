class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user

  validates :content, presence: true

  after_create_commit :broadcast_creation
  after_update_commit :broadcast_update
  after_destroy_commit -> { broadcast_remove_to room }

  private

  def broadcast_creation

    channel = "room_#{room.id}"
    Turbo::StreamsChannel.broadcast_append_to(
      channel,
      target: "room_#{room.id}_messages_list",
      partial: "messages/created_message",
      locals: { message: self }
    )
  end

  def broadcast_update
    Turbo::StreamsChannel.broadcast_replace_to(
      room,
      target: "message_#{id}",
      partial: "messages/message_content",
      locals: { message: self }
    )
  end
end
