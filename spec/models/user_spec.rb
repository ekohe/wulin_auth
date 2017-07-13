require 'rails_helper'

RSpec.describe WulinAuth::User, type: :model do
  describe "password complexity" do
    it "should be enforced" do
      u = WulinAuth::User.new(password: 'simplepassword')
      expect(u).not_to be_valid
      expect(u.errors[:password]).not_to be_empty
      expect(u.errors[:password]).to(
        include('Password is not secure, please try a more complex password')
      )

      u.password = "fdsi1*w0a91jk"
      expect(u).not_to be_valid
      expect(u.errors[:password]).to be_empty
    end
  end
end
