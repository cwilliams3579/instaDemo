Rails.application.routes.draw do
  resources :plays
  get 'plays/index'

  get 'plays/show'

  root to: 'visitors#index'
end
