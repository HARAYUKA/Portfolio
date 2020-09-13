class TeachersController < ApplicationController
  before_action :set_teacher, only: [:show, :edit, :update]
  before_action :logged_in_teacher, only: [:show, :edit, :update]
  before_action :correct_teacher, only: [:edit, :update]

  def show
  end

  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.new(teacher_params)
    if @teacher.save
      flash[:success] = '新規作成に成功しました。'
      redirect_to @teacher
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @teacher.update_attributes(teacher_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @teacher
    else
      render :edit      
    end
  end

  private

      def teacher_params
        params.require(:teacher).permit(:name, :email, :password, :password_confirmation)
      end

      # paramsハッシュからユーザーを取得します。
      def set_teacher
        @teacher = Teacher.find(params[:id])
      end

      # ログイン済みのユーザーか確認します。
      def logged_in_teacher
        unless teacher_logged_in?
          flash[:danger] = "ログインしてください。"
          redirect_to login_url
        end
      end

      # アクセスしたユーザーが現在ログインしているユーザーか確認します。
      def correct_teacher
        @teacher = Teacher.find(params[:id])
        redirect_to(root_url) unless @teacher == current_teahcer
      end

end
