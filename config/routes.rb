Rails.application.routes.draw do
  root to: 'home#index'
  resources :mode_of_transports, only: [:new, :create, :show, :index, :edit, :update]

end
