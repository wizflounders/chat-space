require 'rails_helper'
describe Message do
  describe '#create' do
    let(:user) { create(:user) }
    it "is valid with a message and an image" do
    message = create(:message, user_id: user.id, group_id: user.groups.first.id)
    expect(message).to be_valid
    end

    it "is valid with an image although without a message" do
      message = create(:message, body:'',  user_id: user.id, group_id: user.groups.first.id)
      expect(message).to be_valid
    end

    it "is valid with a message although without an image" do
      message = create(:message, user_id: user.id, group_id: user.groups.first.id, image: nil)
      expect(message).to be_valid
    end

    it "is invalid without message and image " do
        message = build(:message,  user_id: user.id, group_id: user.groups.first.id, image: nil)
        message.body = nil
        expect(message.errors[:body_or_image]).to include("メッセージもしくは画像を入力してください")
    end
  end
end
