Rails.application.routes.draw do
  match 'login' => "user_sessions#new", :as => :login, :via => :get
  match 'login' => "user_sessions#create", :as => :login, :via => :post
  match 'logout' => "user_sessions#destroy", :as => :logout
end