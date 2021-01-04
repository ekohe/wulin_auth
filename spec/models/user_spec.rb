# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WulinAuth::User, type: :model do
  let(:user) { described_class.new(password: 'fdsi1*w0a91jk') }

  describe "password complexity" do
    it "should be enforced" do
      user.password = 'simplepassword'
      expect(user).not_to be_valid
      expect(user.errors[:password]).not_to be_empty
      expect(user.errors.full_messages).to(
        include('Password is not secure, please try a more complex password')
      )

      user.password_confirmation = 'simplepassword test'
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to(
        include("Password confirmation doesn't match with password")
      )

      user.password = "fdsi1*w0a91jk"
      expect(user).not_to be_valid
      expect(user.errors[:password]).to be_empty
    end
  end

  describe 'validate email' do
    it 'should save lower case email' do
      user.email = 'ekohe@ekohe.com'
      user.save

      expect(user.reload.email).to eq('ekohe@ekohe.com')
    end

    it 'should save the unique email' do
      user.email = 'ekohe@ekohe.com'
      user.save

      user_with_existing_email = described_class.new(password: 'fdsi1*w0a91jk', email: 'ekohe@ekohe.com')

      expect(user_with_existing_email).not_to be_valid
      expect(user_with_existing_email.errors[:email]).to include('has already been taken')
    end
  end
end
