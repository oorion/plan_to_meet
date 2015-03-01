Rails.application.routes.draw do
  get 'welcome/index'
  root 'welcome#index'

  resources :users

  post 'login', to: 'sessions#create', as: 'login'
  delete 'logout', to: 'sessions#destroy', as: 'logout'
end
