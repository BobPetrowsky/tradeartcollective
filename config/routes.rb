Rails.application.routes.draw do
  resources :users, only: [:index, :show] do
    resources :items, only: [:new, :create, :update, :edit, :destroy]
    resources :abouts, only: [:edit, :update]
    resources :sales, only: [:index, :show]
  end
  root "users#index"
  get '/auth/:facebook/callback', to: 'sessions#create'
  get '/signout' => "sessions#destroy", :as => :signout
  get '/users/:action(/:user_id)', :controller => 'users'
  get '/users/:user_id(/:item_id)/:action', :controller => 'items'
  put "mark-as-shipped", to: 'sales#mark_as_shipped'
  put "refund-payment", to: 'sales#refund_payment'
  put "relist-item", to: 'items#relist_item'
end
