Rails.application.routes.draw do
  root 'home#top'

  get '/signup', to: 'users#new'

  # ログイン機能
  get    'parent/login', to: 'sessions#parent_login'
  get    'nursery/login', to: 'sessions#nursery_login'
  post   'parent/login', to: 'sessions#parent_create'
  post   'nursery/login', to: 'sessions#nursery_create'
  delete '/logout', to: 'sessions#destroy'

  resources :parents

  resources :nurseries
end
