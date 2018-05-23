Rails.application.routes.draw do
  get 'sessions/index'
  get 'sessions/create'
  get 'sessions/edit'
  get 'sessions/show'
  get 'sessions/update'
  get 'attendances/index'
  get 'attendances/edit'
  get 'attendances/update'
  get 'index/create'
  get 'index/edit'
  get 'index/show'
  get 'index/update'
  get 'index/destroy'
  get 'student_rosters/create'
  get 'students/index'
  get 'students/create'
  get 'students/show'
  devise_for :users
  root to: 'pages#home', as: :home

  resources :courses do
    resources :sessions, except: [:new]
    resources :attendances, only: [:index, :edit, :update]
    resources :student_rosters, only: [:create, :destroy]
    resources :volunteer_rosters, only: [:create, :destroy]
  end

  resources :subjects, only: :create
  resources :students, only: [:index, :show, :create]
  resources :volunteers, only: [:index, :show, :create]
  resources :addresses, only: :create
end
