# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }

  root 'posts#index'

  resource :user, only: %i[] do
    get :login, to: 'user#login'
    get :logout, to: 'user#logout'
    post :accept, to: 'user#accept'
  end

  resources :posts, only: %i[index show new create] do
    resources :comments, only: %i[create]
    resource :like, only: %i[destroy create] do
      post :toggle, to: 'likes#toggle'
      # delete :destroy, path: 'likes#destroy'
    end
    resources :likes, only: %i[create destroy]
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
  get 'exception_check' => 'monitor#exception_check', as: :rails_exception
  get 'sentry_check' => 'monitor#sentry_check', as: :sentry_exception

  # Render dynamic PWA files from app/views/pwa/*
  get 'service-worker' => 'rails/pwa#service_worker', as: :pwa_service_worker
  get 'manifest' => 'rails/pwa#manifest', as: :pwa_manifest

  # Defines the root path route ("/")
end
