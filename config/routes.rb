Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :mode_of_transports, only: [:new, :create, :show, :index, :edit, :update] do
    resources :price_by_weights, only: [:new, :create, :index, :edit, :update]
    resources :price_per_distances, only: [:new, :create, :index, :edit, :update]
    resources :delivery_times, only:[:new, :create, :index, :edit, :update]
    patch 'activated', on: :member
    patch 'disable', on: :member
  end

  resources :vehicles, only: [:new, :create, :show, :index, :edit, :update] do
    patch 'in_operation', on: :member
    patch 'in_maintenance', on: :member
    get 'search', on: :collection
  end

  resources :create_order_of_services, only: [:new, :create, :show, :index, :edit, :update]
end
