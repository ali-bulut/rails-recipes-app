Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root "pages#home"
  get "/pages/home", to: 'pages#home'

  resources :recipes

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/signup', to: 'chefs#new'
  # get all the routes except new
  resources :chefs, except: [:new]
  resources :ingredients, except: [:destroy]
end
