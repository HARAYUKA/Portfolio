Rails.application.routes.draw do
  root 'home#top'

  # ログイン機能
  get    'parent/login', to: 'sessions#parent_login'
  get    'teacher/login', to: 'sessions#teacher_login'
  post   'parent/login', to: 'sessions#parent_create'
  post   'teacher/login', to: 'sessions#teacher_create'
  delete 'parent/logout', to: 'sessions#parent_destroy'
  delete 'teacher/logout', to: 'sessions#teacher_destroy'

  resources :parents

  resources :teachers
end
