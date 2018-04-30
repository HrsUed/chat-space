class Message < ApplicationRecord
  belongs_to :group
  belongs_to :user

  validates :content, presence: true, if: -> { image.blank? }
  validates :image, presence: true, if: -> { content.blank? }

  mount_uploader :image, ImageMessageUploader

  protected

  def self.get_messages_after_last_update(message_id)
    Message.where("id > ?", message_id)
  end

end
