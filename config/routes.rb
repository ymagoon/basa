Rails.application.routes.draw do
  devise_for :users
  root to: 'dashboard#home', as: :home
    resources :dashboard, only: [] do
      collection do
        get 'volunteers', to: "dashboard#volunteers"
        get 'students', to: "dashboard#students"
        get 'attendance', to: "dashboard#attendance"
      end
    end


  resources :courses do
    resources :sessions, except: [:new, :create]
    resources :attendances, only: [:index]

    resources :student_rosters, only: [:index]
    patch '/attendance', to: 'attendances#update'
    post '/student_rosters/:student_id', to: 'student_rosters#create'

    resources :volunteer_rosters, only: [:new, :create, :destroy, :edit, :update]
  end
  resources :student_rosters, only: [:destroy]
  resources :subjects, only: :create
  resources :students, only: [:index, :show, :create]
  resources :volunteers, only: [:index, :show, :create]
  resources :addresses, only: :create
end
