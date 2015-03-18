Rails.application.routes.draw do
  get 'welcome/index'
  root 'welcome#index'

  get '/auth/:provider/callback', to: 'sessions#create'

  resources :users, only: [:show, :edit, :update], path_names: {edit: 'preferences'}
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show]
    end
  end
end
