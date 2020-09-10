class SessionsController < ApplicationController
  def parent_login
  end

  def teacher_login
  end

  def parent_create
    parent = Parent.find_by(email: params[:session][:email].downcase)
    if parent && parent.authenticate(params[:session][:password])
      log_in_parent parent
      redirect_to parent
    else
      flash.now[:danger] = '認証に失敗しました。'
      render :parent_login
    end
  end

  def teacher_create
    teacher = Teacher.find_by(email: params[:session][:email].downcase)
    if teacher && teacher.authenticate(params[:session][:password])
      log_in_teacher teacher
      redirect_to teacher
    else
      flash.now[:danger] = '認証に失敗しました。'
      render :teacher_login
    end
  end

  def parent_destroy
    logout_parent
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end

  def teacher_destroy
    logout_teacher
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end

end
