Rails.application.routes.draw do
  root to: 'homepage#index'

  mount WulinAuth::Engine => "/wulin_auth"
end
