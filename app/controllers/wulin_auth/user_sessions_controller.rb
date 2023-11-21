# frozen_string_literal: true

module WulinAuth
  class UserSessionsController < ActionController::Base
    before_action :require_login, only: [:destroy]
    layout 'wulin_auth'

    # GET /login
    def new
      respond_to do |format|
        format.html { render }
      end
    end

    # POST /login
    def create
      user = WulinAuth::User.find_by(email: params[:email].try(:downcase))
      if user.try(:authenticate, params[:password])
        session[:user_id] = user.id
        respond_to do |format|
          redirect_url = (session[:return_to] || '/')
          format.html { redirect_to redirect_url }
          format.json do
            render json: { status: :success,
                           message: t('wulin_auth.user_sessions.successful'),
                           user_id: current_user.id,
                           redirect_to: redirect_url }
          end
        end
      else
        respond_to do |format|
          format.html do
            flash[:notice] = t('wulin_auth.user_sessions.incorrect')
            render :new
          end
          format.json do
            render json: { status: :wrong_credentials,
                           message: t('wulin_auth.user_sessions.incorrect') }
          end
        end
      end
    end

    # GET /logout
    def destroy
      reset_session
      redirect_path = params[:redirect_uri].presence || login_path
      redirect_to redirect_path, allow_other_host: true
    end
  end
end
