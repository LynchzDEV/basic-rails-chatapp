class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user

  validates :content, presence: true

  after_create_commit -> { broadcast_append_to [room, "messages"] }
  after_update_commit -> { broadcast_replace_to [room, "messages"] }
  after_destroy_commit -> { broadcast_remove_to [room, "messages"] }
end
