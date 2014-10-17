Rails.application.routes.draw do
  resources :users, only: [:index, :show, :new, :create, :update, :edit] do
    resources :items, only: [:show, :new, :create, :update, :edit, :destroy]
    resources :sales, only: [:index, :show]
  end
  get '/auth/:facebook/callback', to: 'sessions#create'
  get '/signout' => "sessions#destroy", :as => :signout
  get '/users/:action(/:user_id)', :controller => 'users'
  get '/users/:user_id(/:item_id)/buy', to: 'items#buy'
  put "mark-as-shipped", to: 'sales#mark_as_shipped'
  put "refund-payment", to: 'sales#refund_payment'
  put "relist-item", to: 'items#relist_item'
  root 'items#index'
end
