require 'test_helper'
require 'action_controller/test_case'

class UserSessionsControllerTest < ActionController::TestCase
  tests UserSessionsController
  
  def setup
    @controller = UserSessionsController.new
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
    assert_template "user_sessions/new"
  end
  
  test "post logout" do
    get :destroy
    assert_response 302, @response.status
    assert_redirected_to login_path
  end

end
