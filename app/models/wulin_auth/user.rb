class WulinAuth::User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :user_level
  has_secure_password
  validates :email, :presence => true, :uniqueness => true
end