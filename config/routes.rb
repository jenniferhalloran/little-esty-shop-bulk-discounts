Rails.application.routes.draw do
  root to: 'welcome#index'
  get '/merchants/:merchant_id/dashboard', to: 'merchants#show'


  resources :admin, only: [:index]

  resources :merchants, except: [:show] do
    resources :items, only: [:index, :show, :edit, :update, :new, :create]
    resources :invoices, only: [:index, :show, :update]
    resources :discounts, only: [:index, :show, :new, :create, :destroy, :edit, :update]
  end

  namespace :admin do
    resources :merchants, only: [:index, :show, :update, :edit, :new, :create]
    resources :invoices, only: [:index, :show, :update]
  end
end
