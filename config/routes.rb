Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  authenticated :user do
    root 'lists#index', as: :authenticated_root
  end

  resources :lists


end
