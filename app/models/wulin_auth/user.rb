class WulinAuth::User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  has_secure_password
  validates :email, :presence => true, :uniqueness => true
end

