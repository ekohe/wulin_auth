# frozen_string_literal: true

module WulinAuth
  class PasswordResetsController < ApplicationController
    include Rails.application.routes.url_helpers
    layout 'wulin_auth'
    def new; end

    def create
      @user = User.where(email: params[:email].try(:downcase)).first
      if @user
        if @user.send_password_reset!
          redirect_to password_resets_email_sent_path
        else
          flash.now[:notice] = t('wulin_auth.password_resets.error')
          render :new
        end
      else
        flash.now[:notice] = t('wulin_auth.password_resets.email_non_existent')
        render :new
      end
    end

    def email_sent; end

    def reset
      @user = User.by_token(params[:token]).first
      return if @user

      flash.now[:notice] = t('wulin_auth.password_resets.error')
      render :new
    end

    def password_complexity
      if params[:password].blank?
        render json:
          {
            valid: false,
            error: t('wulin_auth.password_resets.password_cannot_be_blank')
          }
        return
      end
      @user = User.new(password: params[:password])
      @user.valid?
      response = { valid: @user.errors[:password].none? }
      if @user.errors[:password].any?
        response[:error] = @user.errors[:password].join(', ')
      end
      render json: response
    end

    def update
      @user = User.by_token(params[:id]).first

      unless @user
        flash[:notice] = t('wulin_auth.password_resets.error')
        redirect_to new_password_reset_path
        return
      end

      if params[:user][:password].blank?
        params[:token] = params[:id]
        error_message = t('wulin_auth.password_resets.password_cannot_be_blank')
        @user.errors.add(:password, error_message)
        render :reset
        return
      end

      attributes = permitted_params[:user].
                   merge(token: nil, token_expires_at: nil)
      if @user.update(attributes)
        session[:user_id] = @user.id
        flash[:notice] = t('wulin_auth.password_resets.success')
        redirect_to root_path
      else
        logger.info "[WulinAuth] Error: #{@user.errors.inspect}"
        params[:token] = params[:id]
        render :reset
      end
    end

    private

    def permitted_params
      params.permit(user: %i[password password_confirmation])
    end
  end
end
