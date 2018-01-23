Rails.application.routes.draw do

  resources :courses do
    resources :evaluations do
      member do
        get 'new_grade', to: 'students_grades#new', as: 'new_grade'
        post 'load_grade', to: 'students_grades#load_grade', as: 'load_grade'
        get 'update_grade', to: 'students_grades#update_grade', as: 'update_grade'
      end
    end
    resources :students
  end

  get 'courses/:id/evaluations_grades', to: 'courses#evaluations_grades', as: 'course_grades'

  resources :users, only: [:new, :create]
  get '/sign_up', to: 'users#new', as: :sign_up

  resources :sessions, only: [:new, :create, :destroy]
  get '/log_in', to: 'sessions#new', as: :log_in
  delete '/log_out', to: 'sessions#destroy', as: :log_out

  root 'sessions#new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
