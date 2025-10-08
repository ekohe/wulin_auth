require 'engine' if defined?(Rails)

module WulinAuth
  mattr_accessor :password_reset_email_from

  class << self
    password_reset_email_from = "noreply@domain.tld"
  end

  def self.setup(&_block)
    yield self
  end
end

require 'application_controller'
require 'haml'
