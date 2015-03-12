Rails.application.routes.draw do
  get 'welcome/index'
  root 'welcome#index'

  get '/auth/:provider/callback', to: 'sessions#create'

  resources :users, only: [:show] do
    get 'preferences'
  end

#  post 'login', to: 'sessions#create', as: 'login'
#  delete 'logout', to: 'sessions#destroy', as: 'logout'
end
