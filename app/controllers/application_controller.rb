class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  # paramsハッシュからユーザーを取得します。
  def set_parent
    @parent = Parent.find(params[:id])
  end

  def set_teacher
    @teacher = Teacher.find(params[:id])
  end

  # ログイン済みのユーザーか確認します。
  def logged_in_parent
    unless parent_logged_in?
      store_location
      flash[:danger] = "ログインしてください。"
      redirect_to parent_login_url
    end
  end

  def logged_in_teacher
    unless teacher_logged_in?
      store_location
      flash[:danger] = "ログインしてください。"
      redirect_to teacher_login_url
    end
  end

  # # 園の管理者かどうかを確認
  # def admin_teacher
  #   redirect_to root_url unless current_teacher.admin?
  # end

  # アクセスしたユーザーが現在ログインしているユーザーか確認します。
  def correct_parent
    redirect_to(root_url) unless current_parent?(@parent)
  end

  def correct_teacher
    redirect_to(root_url) unless current_teacher?(@teacher)
  end
end
