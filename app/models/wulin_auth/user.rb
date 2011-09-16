class WulinAuth::User < ActiveRecord::Base
  attr_accessible :login, :password, :password_confirmation
  has_secure_password
  validates :login, :presence => true, :uniqueness => true
  
  has_many :grid_states
end

