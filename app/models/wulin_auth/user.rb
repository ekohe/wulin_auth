# frozen_string_literal: true

require WulinAuth::Engine.root.join('lib', 'password_complexity_validator')

module WulinAuth
  class User < ApplicationRecord
    before_save { self.email = email.downcase }

    has_secure_password

    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: { case_sensitive: false }
    validates :password, presence: true
    validates_with PasswordComplexityValidator

    scope :by_token, lambda { |token|
      where(["token = ? AND token_expires_at > ?", token, Time.current])
    }

    def create_token
      self.token = SecureRandom.urlsafe_base64
      self.token_expires_at = 24.hours.from_now
    end

    def send_password_reset!
      create_token
      # sometimes the password is not required, so we'd better skip validating when resetting token
      if save(validate: false)
        PasswordResetMailer.reset_password(self).deliver
      else
        false
      end
    end
  end
end
