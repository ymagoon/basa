Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home', as: :home

  resources :courses do
    resources :sessions, except: [:new, :create]
    resources :attendances, only: [:index, :edit, :update]
    resources :student_rosters, only: [:create, :destroy]
    resources :volunteer_rosters, only: [:new, :create]
  end

  # note that the volunteer routes actually refer to users since there's no volunteer model. Where you see :volunteer_id => this refers to the :user_id. (e.g. in Proficiencies)
  resources :volunteers, only: [:index, :show] do
    resources :proficiencies, only: [:new, :create]
  end

  resources :subjects, only: [:create]
  resources :students, only: [:index, :show, :create]
  resources :addresses, only: [:create]
  resources :volunteer_rosters, only: [:destroy]
  resources :proficiencies, only: [:destroy]
end
