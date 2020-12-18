# frozen_string_literal: true

require 'wulin_auth/engine' if defined?(Rails) && Rails::VERSION::MAJOR >= 5

module WulinAuth
  mattr_accessor :password_reset_email_from, default: 'noreply@domain.tld'

  def self.setup(&_block)
    yield self
  end
end

require 'application_controller'
require 'jquery-rails'
require 'sass-rails'
require 'coffee-script'
require 'haml'
require 'materialize-sass'
require 'material_icons'

if defined? WulinMaster
  WulinMaster::AppBarMenu.menus.add_menu(:user_menu,
                                         icon: :account_circle,
                                         label: -> { current_user&.email },
                                         class: "dropdown-trigger",
                                         data: { target: "user_menu-list" },
                                         order: 1000) do |sub_menu|
    sub_menu.add_menu(:logout,
                      label: 'Logout',
                      icon: :eject,
                      order: 1000, # large enough
                      url: -> { logout_path })
  end
end
