require 'rails_helper'

describe Message do
  describe '#create' do

    context 'Succeed to save messages' do

      it 'is valid with only a message content' do
        message = build(:message, image: nil)

        expect(message).to be_valid
      end

      it 'is valid with only a message image' do
        message = build(:message, content: nil)

        expect(message).to be_valid
      end

      it 'is valid with a message content and image' do
        message = build(:message)

        expect(message).to be_valid
      end
    end

    context 'Fail to save messages' do
      it 'is invalid without a message content and image' do
        message = build(:message, content: nil, image: nil)
        message.valid?
        expect(message.errors[:content]).to include("を入力してください。")
      end

      it 'is invalid without a group_id' do
        message = build(:message, group_id: nil)
        message.valid?
        expect(message.errors[:group]).to include("を入力してください。")
      end

      it 'is invalid without a user_id' do
        message = build(:message, user_id: nil)
        message.valid?
        expect(message.errors[:user]).to include("を入力してください。")
      end

    end
  end
end
