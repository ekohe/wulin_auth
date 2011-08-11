require 'spec_helper'
require 'wulin_auth/controllers/user_sessions_controller'

describe UserSessionsController, :type => :controller do
  before :each do 
    @user = User.new(:login => "jimmy", :password => "jimmy")
    @user.save
  end
  
  it "should be successful" do
    get :new
    response.should be_success
  end

  it "should be successful with the correct 'login' and 'password'" do
    post :create, :user => {:login => "jimmy", :password => "jimmy"}
    response.should be_success
    response.should redirect_to(login_path)
  end
  
  it "should fail with the wrong 'login' and 'password'" do
    post :create, :user => {:login => "jimmy", :password => "xuhao"}
    response.should_not be_success
    response.should redirect_to(login_path)
  end
  
  it "should redirect to login page after log out" do
    get :destroy
    response.response_code.should == 302 
    response.should redirect_to("/")
  end
end
