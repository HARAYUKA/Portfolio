class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  $days_of_the_week = %w{日 月 火 水 木 金 土}

  # paramsハッシュから保護者を取得します。
  def set_parent
    @parent = Parent.find(params[:id])
  end

  # paramsハッシュから先生を取得します。
  def set_teacher
    @teacher = Teacher.find(params[:id])
  end

  # アクセスしたユーザーが現在ログインしている保護者か確認します。
  def correct_parent
    redirect_to(root_url) unless current_parent?(@parent)
  end

  # アクセスしたユーザーが現在ログインしている先生か確認します。
  def correct_teacher
    redirect_to(root_url) unless current_teacher?(@teacher)
  end

  # ログイン済みの保護者か確認します。
  def logged_in_parent
    unless parent_logged_in?
      store_location
      flash[:danger] = "ログインしてください。"
      redirect_to parent_login_url
    end
  end

  # ログイン済みの先生か確認します。
  def logged_in_teacher
    unless teacher_logged_in?
      store_location
      flash[:danger] = "ログインしてください。"
      redirect_to teacher_login_url
    end
  end

  # 園の管理者でない場合
  def not_admin_teacher
    if current_teacher != nil # teacherだったら下の処理
      redirect_to root_url unless current_teacher.admin? # teacherがadminの場合の処理
    else # teacherではなかったら下の処理
      flash[:danger] = "権限がありません。"
      redirect_to root_url
    end
  end

  # 管理者の場合
  def admin_teacher
    if current_teacher.admin?
      flash[:danger] = "管理者は表示出来ません。"
      redirect_to root_url
    end
  end

  
end
