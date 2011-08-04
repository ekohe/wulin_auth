module WulinAuth
  def logged_in?
    !current_user.nil?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def on_login_page?
    params[:controller] == "user_sessions" && ["new", "create"].include?(params[:action])
  end

  def require_login
    if !logged_in? && !on_login_page?
      return unauthorized_response
    else
      logger.warn "Authenticated as #{current_user.UserLogin}" unless on_login_page?
    end
  end

  def unauthorized_response
    respond_to do |format|
      format.html do
        flash[:notice] = "You must be logged in to access this page."
        redirect_to login_path
      end
      format.json { render :json => {:error => :not_authorized} }
    end
    false
  end
end

ApplicationController.send(:include, WulinAuth)
ApplicationController.send(:helper_method, :current_user)
