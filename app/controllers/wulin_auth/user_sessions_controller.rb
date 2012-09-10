class WulinAuth::UserSessionsController < ActionController::Base

  skip_before_filter :require_login, :only => [:new, :create]
  layout 'wulin_auth'
  
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
    redirect_path = params[:redirect_uri].presence || login_path
    redirect_to redirect_path
  end
end
