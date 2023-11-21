# frozen_string_literal: true

module OmniauthHelper
  def omniauth_microsoft_configured?
    OmniAuth::Builder && (defined? APP_CONFIG) && APP_CONFIG&.dig("OFFICE365_KEY")
  rescue NameError
    Rails.logger.error "OmniAuth for Microsoft has not been configured!"
    false
  end
end
