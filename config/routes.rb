# frozen_string_literal: true

Rails.application.routes.draw do
  get 'login', to: 'wulin_auth/user_sessions#new'
  post 'login', to: 'wulin_auth/user_sessions#create'
  get 'logout', to: 'wulin_auth/user_sessions#destroy'

  resources :password_resets, module: 'wulin_auth', only: %i[new create update]
  get "reset_password/email_sent" => "wulin_auth/password_resets#email_sent", as: :password_resets_email_sent
  get "reset_password/:token" => "wulin_auth/password_resets#reset", as: :password_reset_token
  get "setup_password/:token" => "wulin_auth/password_resets#reset", as: :password_setup_token
  post "reset_password/password_complexity" => "wulin_auth/password_resets#password_complexity", as: :password_complexity
end
