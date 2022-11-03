Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'home#index'
  get '/create-project', to: 'create_project#index'

  namespace :api do
    post 'create-project', to: 'create_project#store'
  end
end
