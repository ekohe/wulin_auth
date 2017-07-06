# frozen_string_literal: true

module WulinAuth
  class PasswordResetMailer < ActionMailer::Base
    def reset_password(user)
      @user = user

      mail from: WulinAuth.password_reset_email_from,
           to: user.email,
           subject: t('wulin_auth.password_resets.email_subject')
    end
  end
end
