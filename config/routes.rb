AlwaysInMyMemory::Application.routes.draw do


  resources :cards,:users, :sessions
  root to: "cards#index", as: :home

  get '/signup' => 'users#new'
  get '/signout', to: 'sessions#destroy', via: :delete
  get'/signin', to: 'sessions#new'


  get "/users/:id/cards/show", to: 'cards#show', as: :show
  get "/users/:id/practice", to: 'cards#practice', as: :practice
  get "/users/:id/learned", to: 'cards#learned', as: :learned
  
   get "/users/:id/reserve", to: 'cards#reserve', as: :reserve
   post "users/:id/reserve", to: 'cards#create'

   post "/practice", to: "cards#viewed_stack"

   

 end


  
