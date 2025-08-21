# In config/routes.rb
Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'

  namespace :admin do
    root 'dashboard#index'
    resources :posts do
      member { patch :toggle_status }
    end
    resources :users, only: [:index, :destroy]
    resources :comments, only: [:index, :destroy]
    # ... other admin routes
  end

  # --- Public-Facing Section ---
  # This is the FIX. We are enabling all actions for posts,
  # which creates new_post_path, edit_post_path, etc.
  resources :posts do

    member do
      patch :publish
    end

    get 'search', on: :collection
    resources :comments, only: [:create, :destroy]
  end

  get 'dashboard', to: 'users#dashboard', as: 'dashboard_user'
end