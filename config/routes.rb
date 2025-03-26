Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions" }

  root "posts#index"

  resource :user, only: %i[] do
    get :login, to: "user#login"
    get :logout, to: "user#logout"
    post :accept, to: "user#accept"
  end

  resources :posts, only: %i[index show new create] do
    resources :comments, only: %i[create]
    resource :like, only: %i[] do
      post :toggle, as: '', to: "likes#toggle"
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
end
