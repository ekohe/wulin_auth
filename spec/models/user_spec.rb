require 'spec_helper'
require 'mass_assign_matcher'
require 'wulin_auth/models/user'

describe "User" do
  load_schema
  
  before :each do
    @user = User.new(:login => "jimmy", :password => "jimmy", :password_confirmation => "jimmy")
  end
  
  it "should have a login" do
    @user.stub!(:login) { nil }
    @user.should_not be_valid
  end
  
  it "should have a unique login" do
    @user.save
    @another_user = User.new(:login => @user.login, :password => "jimmy3", :password_confirmation => "jimmy2")
    @another_user.save
    @another_user.errors[:login].should include("has already been taken")
  end
  
  it "should allow mass assignment to password, password_confirmation and login" do
    @user.should allow_mass_assignment_of(:login => "jam")
    @user.should allow_mass_assignment_of(:password => "jam")
    @user.should allow_mass_assignment_of(:password_confirmation => "jam")
  end
end