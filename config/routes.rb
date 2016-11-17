Rails.application.routes.draw do
  get 'login', to: 'wulin_auth/user_sessions#new'
  post 'login', to: 'wulin_auth/user_sessions#create'
  get 'logout', to: 'wulin_auth/user_sessions#destroy'
end
