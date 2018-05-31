Rails.application.routes.draw do
  devise_for :users
  root to: 'dashboard#home', as: :home
    resources :dashboard, only: [] do
      collection do
        get 'statistics', to: "dashboard#statistics"
        get 'attendance', to: "dashboard#attendance"
      end
    end
  resources :courses do
    resources :sessions, except: [:new, :create]
    resources :attendances, only: [:index]
    resources :student_rosters, only: [:index]
    patch '/attendance', to: 'attendances#update'
    post '/student_rosters/:student_id', to: 'student_rosters#create'
    resources :volunteer_rosters, only: [:new, :create]
  end



  resources :subjects, only: [:create]
  resources :students, only: [:index, :show, :create]
  resources :addresses, only: [:create]
  resources :volunteer_rosters, only: [:destroy]
  resources :student_rosters, only: [:destroy]
  resources :proficiencies, only: [:destroy]

  # note that the volunteer routes actually refer to users since there's no volunteer model. Where you see :volunteer_id => this refers to the :user_id. (e.g. in Proficiencies)
  resources :volunteers, only: [:index, :show] do
    resources :proficiencies, only: [:new, :create]
  end

  get 'test', to: 'pages#home', as: :test
end
