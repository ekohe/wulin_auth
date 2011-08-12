module WulinAuth
  class User < ActiveRecord::Base
    attr_accessible :login, :password, :password_confirmation
    has_secure_password
    validates :login, :presence => true, :uniqueness => true
  end
end
