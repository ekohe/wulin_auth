class WulinAuth::UserSessionsController < ApplicationController
  self.view_paths = [File.join(Rails.root, 'app', 'views'), File.join(File.dirname(__FILE__), '../..', 'views')]

  skip_before_filter :require_login, :only => [:new, :create]
  layout :wulin_auth
  
  # GET /login
  def new
    respond_to do |format|
      format.html { render }
    end
  end

  def create
    user = WulinAuth::User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      respond_to do |format|
        redirect_url = (session[:return_to] || '/')
        format.html { redirect_to redirect_url }
        format.json { render :json => {:status => :success, :user_id => current_user.id, :redirect_to => redirect_url} }
      end
    else
      respond_to do |format|
        format.html do
          flash[:notice] = "Username or password incorrect."
          render :new
        end
        format.json { render :json => {:status => :wrong_credentials} }
      end
    end
  end

  def destroy
    reset_session
    redirect_to login_path
  end
end
