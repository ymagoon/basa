Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home', as: :home

  resources :courses do
    resources :sessions, except: [:new, :create]
    resources :attendances, only: [:index, :edit, :update]

    resources :student_rosters, only: [:index, :destroy]
    post '/student_rosters/:student_id', to: 'student_rosters#create'

    resources :volunteer_rosters, only: [:new, :create, :destroy, :edit, :update]
  end

  resources :subjects, only: :create
  resources :students, only: [:index, :show, :create]
  resources :volunteers, only: [:index, :show, :create]
  resources :addresses, only: :create
end
