module WulinAuth
  module AbstractController
    extend ActiveSupport::Concern

    # Instance Methods
      
    def current_user
      @current_user ||= WulinAuth::User.find(session[:user_id]) if session[:user_id]
    end
  end
end

::AbstractController::Base.send :include, WulinAuth::AbstractController

module WulinAuth
  module Controller
    ## this one manages the usual self.included, klass_eval stuff
    extend ActiveSupport::Concern
    
    included do
      class_eval do
        helper_method :current_user
      end
    end

    def on_login_page?
      params[:controller] == "wulin_auth/user_sessions" && ["new", "create"].include?(params[:action])
    end

    def require_login
      if current_user.nil?
        return unauthorized_response
      else
        session.delete(:return_to) if session[:return_to]
        logger.warn "Authenticated as #{current_user.email}"
      end
    end

    def unauthorized_response(message="You must be logged in to access this page.")
      respond_to do |format|
        format.html do
          session[:return_to] = request.get? ? request.url : nil
          Rails.logger.info "Authentication needed, redirecting to login page"
          Rails.logger.info "Saving return to url to #{session[:return_to]}" if session[:return_to]
          flash[:notice] = message
          redirect_to login_path
        end
        format.json { render :json => {:error => :not_authorized} }
      end
      false
    end
  end
end

::ActionController::Base.send :include, WulinAuth::Controller
