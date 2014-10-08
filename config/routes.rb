Rails.application.routes.draw do
  resources :users, only: [:index, :show] do
    resources :items, only: [:create, :edit, :update]
    resources :abouts, only: [:edit, :update]
  end
  root "users#index"
  get '/auth/:facebook/callback', to: 'sessions#create'
  get '/signout' => "sessions#destroy", :as => :signout
end
