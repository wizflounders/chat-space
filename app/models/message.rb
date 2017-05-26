class Message < ApplicationRecord
  belongs_to :user
  belongs_to :group
  validates :body_or_image, presence: {message: "メッセージもしくは画像を入力してください"}

  private
  def body_or_image
    body.presence or image.presence
  end
end
