class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user

  validates :content, presence: true

  broadcasts_to :room
end
