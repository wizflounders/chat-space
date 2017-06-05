require 'rails_helper'
describe Message do
  describe '#create' do
    let(:user) { create(:user) }
    it "is valid with a message and an image" do
    message = build(:message, user_id: user.id, group_id: user.groups.first.id)
    expect(message).to be_valid
    end

    it "is valid with an image although without a message" do
      message = build(:message, body: nil,  user_id: user.id, group_id: user.groups.first.id)
      expect(message).to be_valid
    end

    it "is valid with a message although without an image" do
      message = build(:message, user_id: user.id, group_id: user.groups.first.id, image: nil)

      expect(message).to be_valid
    end

    it "is invalid without message and image " do
        message =  build(:message, user_id: user.id, group_id: user.groups.first.id, image: nil, body: nil)
        message.valid?
        expect(message.errors.messages[:body_or_image][0]).to include("メッセージもしくは画像を入力してください")
    end

    it "is invalid without user_id" do
      message = build(:message, group_id: user.groups.first.id, user_id: nil)
      message.valid?
      expect(message.errors.messages[:user]).to include("を入力してください")
    end

    it "is invalid without group_id" do
      message = build(:message, group_id: nil, user_id: user.id)
      message.valid?
      expect(message.errors.messages[:group]).to include("を入力してください")
    end
  end
end
