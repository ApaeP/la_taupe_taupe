Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :moles do
    resources :bookings, only: %i[ create ]
  end
  resources :bookings, only: %i[ update delete ]
end
