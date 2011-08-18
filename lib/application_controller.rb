module WulinAuth
  module Controller
    ## this one manages the usual self.included, klass_eval stuff
    extend ActiveSupport::Concern
    
    module InstanceMethods
      def current_user
        @current_user ||= WulinAuth::User.find(session[:user_id]) if session[:user_id]
      end

      def on_login_page?
        params[:controller] == "wulin_auth/user_sessions" && ["new", "create"].include?(params[:action])
      end

      def require_login
        if current_user.nil?
          return unauthorized_response
        else
          logger.warn "Authenticated as #{current_user.login}"
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
  end
end

::ActionController::Base.send :include, WulinAuth::Controller