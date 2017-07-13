Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  root 'projects#index'
  devise_for :users
  resources :users, only: %i[index show new destroy]
  resources :organisations
  resources :sites, only: %i[show new create destroy]
  resources :projects, only: %i[index show new create destroy]
  resources :slack_settings, only: %i[show new create update edit destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
