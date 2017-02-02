Rails.application.routes.draw do
  devise_for :users
  resources :plays do
    resources :reviews
    
  end
  get 'plays/index'

  get 'plays/show'

  root to: 'visitors#index'
end
