# frozen_string_literal: true

module WulinAuth
  module AbstractController
    extend ActiveSupport::Concern

    def current_user
      return @current_user if defined?(@current_user)

      @current_user ||= if session[:user_id]
        begin
          WulinAuth::User.find(session[:user_id])
        rescue ActiveRecord::RecordNotFound
          nil
        end
      end
    end
  end
end

::AbstractController::Base.include WulinAuth::AbstractController

module WulinAuth
  module Controller
    extend ActiveSupport::Concern

    included do
      helper_method :current_user
    end

    def on_login_page?
      params[:controller] == "wulin_auth/user_sessions" &&
        %w[new create].include?(params[:action])
    end

    def require_login
      return unauthorized_response if current_user.nil?

      session.delete(:return_to) if session[:return_to]
      logger.info "[WulinAuth] Authenticated as #{current_user.email}"
      true
    end

    def unauthorized_response(message = t('wulin_auth.unauthorized_response'))
      respond_to do |format|
        format.html do
          session[:return_to] = request.get? ? request.url : nil
          logger.info '[WulinAuth] Authentication needed, redirecting to login'
          if session[:return_to]
            logger.info "[WulinAuth] Saving return_to: #{session[:return_to]}"
          end
          flash[:notice] = message
          redirect_to login_path
          return false
        end
        format.json do
          render json: {error: :not_authorized}
          return false
        end
      end
    end
  end
end

::ActionController::Base.include WulinAuth::Controller
