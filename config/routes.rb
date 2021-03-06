Rails.application.routes.draw do
  get 'notices/index'
  root 'home#top'

  # ログイン機能
  get    'parent/login', to: 'sessions#parent_login'
  get    'teacher/login', to: 'sessions#teacher_login'
  post   'parent/login', to: 'sessions#parent_create'
  post   'teacher/login', to: 'sessions#teacher_create'
  delete 'parent/logout', to: 'sessions#parent_destroy'
  delete 'teacher/logout', to: 'sessions#teacher_destroy'

  # # LINEログインAPI用
  # get '/parents/auth/line', to: 'parents#line', as: :parents_auth
  # get '/parents/auth/line/callback', to: 'parents#line_login', as: :parents_auth_callback
  # get '/parents/auth/failure', to: 'parents#auth_failure', as: :parents_auth_failure
  
  # get '/teachers/auth/line', to: 'teachers#line', as: :teachers_auth
  # get '/teachers/auth/line/callback', to: 'teachers#line_login', as: :teachers_auth_callback
  # get '/teacheres/auth/failure', to: 'teachers#auth_failure', as: :teachers_auth_failure

  # LINEボットAPI用
  post '/callback' => 'line_bot#callback'

  # 保護者&保護者に紐付く園児
  resources :parents do
    member do
      get 'edit_manag_info' # 管理者が編集可能な情報
      patch 'update_manag_info' # 管理者が編集可能な情報の更新
    end
    resources :children do
      resources :attendances, only: [:update, :index] do
        member do
          get 'confirm_attendance' # 連絡帳確認ボタン
        end
      end
    end
  end

  # 管理者のみが表示可能な園児一覧
  get    'children', to: 'children#all', as: 'all'
  delete 'children/:id', to: 'children#destroy_from_admin', as: 'destroy_from_admin'
  get    'children/edit_class/:id', to: 'children#edit_class', as: 'edit_class'
  patch  'children/update_class/:id', to: 'children#update_class', as: 'update_class'

  # 管理者&保育者
  resources :teachers do
    member do
      get 'edit_manag_info' # 管理者が編集可能な情報
      patch 'update_manag_info' # 管理者が編集可能な情報の更新
      get 'edit_attendance' # 園児の連絡帳画面取得
      patch 'update_attendance/:child_id', to: 'teachers#update_attendance', as: 'update_attendance' # 園児の連絡帳更新
      get 'all_children' # 担当園児一覧表示
      get 'index_attendance/:child_id', to: 'teachers#index_attendance', as: 'index_attendance' # 連絡帳一覧表示
      get 'confirm_attendance/:child_id/:attendance_id', to: 'teachers#confirm_attendance', as: 'confirm_attendance' # 連絡帳確認ボタン
    end
  end

  resources :notices
end
