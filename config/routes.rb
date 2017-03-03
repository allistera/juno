Rails.application.routes.draw do
  devise_for :users
  resources :checks
  resources :sites
  resources :projects
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
