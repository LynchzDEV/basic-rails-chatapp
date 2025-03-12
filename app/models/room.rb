class Room < ApplicationRecord
  validates :name, presence: true
  has_many :messages, dependent: :destroy

  after_create_commit -> { broadcast_append_to "rooms" }
  after_update_commit -> { broadcast_replace_to "rooms" }
  after_destroy_commit -> { broadcast_remove_to "rooms" }
end
