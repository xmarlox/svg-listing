Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  mount Avo::Engine, at: Avo.configuration.root_path

  # Defines the root path route ("/")
  root "illustrations#index"

  resources :illustrations, only: %i(index)
end
