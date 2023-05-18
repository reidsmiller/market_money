Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v0 do
      get '/market/search', to: 'markets#search'
      resources :markets, only: [:index, :show] do
        resources :vendors, only: [:index]
      end
      resources :vendors, except: [:index]
      resources :market_vendors, only: [:create]
      delete '/market_vendors', to: '/market_vendors#destroy'
    end
  end

end
