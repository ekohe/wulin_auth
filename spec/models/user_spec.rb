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
        include("Password is not secure: This is similar to a commonly " \
          "used password\nAdd another word or two. Uncommon words are better.")
      )

      user.password_confirmation = 'simplepassword test'
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to(
        include("Password confirmation doesn't match with password")
      )

      user.password = "fdsi1*w0a91jk"
      expect(user).not_to be_valid
      expect(user.errors[:password]).to be_empty

      user.password = nil
      expect(user).not_to be_valid
      expect(user.errors[:password]).not_to be_empty
      expect(user.errors.full_messages).to(
        include("Password can't be blank")
      )
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

  describe '#send_password_reset!' do
    let(:mailer) { spy('mailer') }

    before do
      user.email = 'wulin_auth@ekohe.com'
      user.token = nil
      user.token_expires_at = nil
      allow(WulinAuth::PasswordResetMailer).to receive(:reset_password).with(user).and_return(mailer)
    end

    context 'user is not valid' do
      before do
        user.password = nil
      end

      it "changes the user's token and send the password reset email" do
        expect(user).not_to be_valid
        expect(mailer).to receive(:deliver)

        user.send_password_reset!

        expect(user.token).not_to be_nil
        expect(user.token_expires_at).not_to be_nil
      end
    end

    context 'user is valid' do
      before do
        user.password = 'fdsi1*w0a91jk'
      end

      it "changes the user's token and send the password reset email" do
        expect(user).to be_valid
        expect(mailer).to receive(:deliver)

        user.send_password_reset!

        expect(user.token).not_to be_nil
        expect(user.token_expires_at).not_to be_nil
      end
    end
  end
end
