module WulinAuth
  class User < ApplicationRecord
    has_secure_password
    validates :email, presence: true, uniqueness: true

    scope :by_token, lambda { |token|
      where(["token = ? AND token_expires_at > ?", token, Time.current])
    }

    def create_token
      self.token = SecureRandom.urlsafe_base64
      self.token_expires_at = 24.hours.from_now
    end

    def send_password_reset!
      create_token
      save
      PasswordResetMailer.reset_password(self).deliver
    end
  end
end
