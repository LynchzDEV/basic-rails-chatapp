class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user

  validates :content, presence: true

  # Make sure these target the correct stream name
  after_create_commit -> { broadcast_append_later_to [room, "messages"], target: "#{ActionView::RecordIdentifier.dom_id(room)}_messages", partial: "messages/message", locals: { message: self, user_id: user_id } }
  after_update_commit -> { broadcast_replace_later_to [room, "messages"] }
  after_destroy_commit -> { broadcast_remove_to [room, "messages"] }
end
