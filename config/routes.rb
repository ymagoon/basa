Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home', as: :home

  resources :courses do
    resources :sessions, except: [:new, :create]
    resources :attendances, only: [:index, :edit, :update]
    resources :student_rosters, only: [:create, :destroy]
    resources :volunteer_rosters, only: [:create, :destroy]
  end

  resources :subjects, only: :create
  resources :students, only: [:index, :show, :create]
  resources :volunteers, only: [:index, :show, :create]
  resources :addresses, only: :create
end
