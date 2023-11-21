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
      # ignore password reset request from microsoft user
      return false if User.microsoft?(self)

      # sometimes the password is not required, so we'd better skip validating when resetting token
      if save(validate: false)
        PasswordResetMailer.reset_password(self).deliver
      else
        false
      end
    end

    def self.microsoft?(user)
      if user&.email
        user_email_domain = user.email.split('@').last.strip.downcase
        User.microsoft_login_email_domain.include? user_email_domain
      else
        false
      end
    end

    def self.microsoft_login_email_domain
      if defined? APP_CONFIG
        APP_CONFIG.dig(Rails.env, "provider_domain", "microsoft") || []
      else
        Rails.logger.error "Missing APP_CONFIG file for provider_domain microsoft Office 365 SSO"
        []
      end
    end
  end
end
