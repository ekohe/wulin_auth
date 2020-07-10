# frozen_string_literal: true

require 'wulin_auth/engine' if defined?(Rails) && Rails::VERSION::MAJOR >= 5

module WulinAuth
  class << self
    mattr_accessor :password_reset_email_from
    self.password_reset_email_from = 'noreply@domain.tld'
  end

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
    sub_menu.add_menu(:change_password,
                      label: 'Change Password',
                      icon: :lock,
                      order: 1,
                      url: -> { new_password_reset_path })
    sub_menu.add_menu(:logout,
                      label: 'Logout',
                      icon: :eject,
                      order: 1000, # large enough
                      url: -> { logout_path })
  end
end
