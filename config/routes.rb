Rails.application.routes.draw do
  devise_for :users

  root "pages#home"

  resources :meal_plans, only: [ :show ]
  resources :user_data, only: [ :index, :show, :new, :create ] do
    collection do
      post "next_step"
      post "previous_step"
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
