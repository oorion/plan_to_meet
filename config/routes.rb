Rails.application.routes.draw do
  get 'welcome/index'
  root 'welcome#index'

  resources :users do
    get 'preferences', to: 'users/preferences#index'
  end

  post 'login', to: 'sessions#create', as: 'login'
  delete 'logout', to: 'sessions#destroy', as: 'logout'
end
