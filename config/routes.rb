Rails.application.routes.draw do
  match 'login' => "wulin_auth/user_sessions#new", :as => :login, :via => :get
  match 'login' => "wulin_auth/user_sessions#create", :as => :login, :via => :post
  match 'logout' => "wulin_auth/user_sessions#destroy", :as => :logout
end