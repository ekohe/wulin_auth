# frozen_string_literal: true

require 'engine' if defined?(Rails) && Rails::VERSION::MAJOR == 5

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
