Rails.application.routes.draw do
  root 'home#top'

  # ログイン機能
  get    'parent/login', to: 'sessions#parent_login'
  get    'teacher/login', to: 'sessions#teacher_login'
  post   'parent/login', to: 'sessions#parent_create'
  post   'teacher/login', to: 'sessions#teacher_create'
  delete 'parent/logout', to: 'sessions#parent_destroy'
  delete 'teacher/logout', to: 'sessions#teacher_destroy'

  resources :parents do
    member do
      get 'edit_manag_info' # 管理者が編集可能な情報
      patch 'update_manag_info' # 管理者が編集可能な情報の更新
    end
    resources :children do
      # member do
      #   get 'edit_child_info' # 園児情報編集モーダル表示
      #   patch 'update_child_info' # 園児情報編集モーダル更新
      # end
      # collection do
      #   get 'children/new' # 園児追加モーダル表示
      #   post 'create' # 園児追加モーダル更新
      # end
    end
  end

  resources :teachers do
    member do
      get 'edit_manag_info' # 管理者が編集可能な情報
      patch 'update_manag_info' # 管理者が編集可能な情報の更新
    end
  end
end
