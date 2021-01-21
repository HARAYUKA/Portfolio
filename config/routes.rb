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
      resources :attendances, only: [:update, :index] do
        member do
          get 'confirm_attendance' # 連絡帳確認ボタン
        end
      end
    end
  end

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
end
