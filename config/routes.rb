# frozen_string_literal: true

Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  root 'projects#index'
  devise_for :users, controllers: { invitations: 'users/invitations' }
  resources :users, only: %i[index show new create destroy update]
  resources :organisations, only: %i[index new create destroy]
  resources :sites, only: %i[show new create destroy] do
    get '/checks', to: 'sites#checks'
  end
  resources :projects, only: %i[index new create destroy]
  resources :slack_settings, only: %i[show new create update edit destroy]
  get '/probes', to: 'probes#index'
  post '/probes', to: 'probes#create'
  get '/probes/health/:id', to: 'probes#health'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
