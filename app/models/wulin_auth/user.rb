require WulinAuth::Engine.root.join('lib', 'password_complexity_validator')

module WulinAuth
  class User < ApplicationRecord
    has_secure_password
    validates :email, presence: true, uniqueness: true
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
      if save
        PasswordResetMailer.reset_password(self).deliver
      else
        false
      end
    end
  end
end
