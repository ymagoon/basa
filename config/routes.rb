Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home', as: :home

  resources :courses do
    resources :sessions, except: [:new, :create]
    resources :attendances, only: [:index, :edit, :update]
    resources :student_rosters, only: [:create, :destroy]
    resources :volunteer_rosters, only: [:new, :create]
  end

  resources :subjects, only: :create
  resources :students, only: [:index, :show, :create]
  resources :volunteers, only: [:index, :show]
  resources :addresses, only: :create
  resources :volunteer_rosters, only: [:destroy]
end
