Rails.application.routes.draw do
  devise_for :users
  root to: 'dashboard#home', as: :home

  resources :courses do
    resources :sessions, except: [:new, :create]
    resources :attendances, only: [:index]

    resources :student_rosters, only: [:index, :destroy]
    patch '/attendance', to: 'attendances#update'
    post '/student_rosters/:student_id', to: 'student_rosters#create'

    resources :volunteer_rosters, only: [:new, :create, :destroy, :edit, :update]
  end

  resources :subjects, only: :create
  resources :students, only: [:index, :show, :create]
  resources :volunteers, only: [:index, :show, :create]
  resources :addresses, only: :create
end
