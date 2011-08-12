require 'test_helper'
require 'controllers/wulin_auth/user_sessions_controller'

class UserSessionsControllerTest < ActionController::TestCase
  tests WulinAuth::UserSessionsController
  
  def setup
    @controller = WulinAuth::UserSessionsController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
    @routes = Rails.application.routes
  end
 
  test "get login page" do
    get :new
    assert_response :success
  end
  
  test "post login" do
    post :create, :user => {:login => "jimmy", :password => "jimmy"}
    assert_response :success
    assert_template "/"
  end
  
  test "post logout" do
    get :destroy
    assert_response 302, @response.status
    assert_redirected_to "/wulin_auth/user_sessions/new"
  end

end