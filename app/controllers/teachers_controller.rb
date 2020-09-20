class TeachersController < ApplicationController
  before_action :set_teacher, only: [:show, :edit, :update, :destroy, :edit_manag_info, :update_manag_info]
  before_action :logged_in_teacher, only: [:index, :show, :edit, :update, :destroy]
  before_action :correct_teacher, only: [:edit, :update]
  # before_action :admin_teacher, only: :destroy

  def index
    @teachers = Teacher.paginate(page: params[:page], per_page: 10)
    if params[:search].present?
      @teachers = Teacher.paginate(page: params[:page]).search(params[:search]) 
    end
  end

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

  def destroy
    @teacher.destroy
    flash[:success] = "#{@teacher.name}のデータを削除しました。"
    redirect_to teachers_url
  end

  def edit_manag_info
  end

  def update_manag_info
    if @teacher.update_attributes(manag_info_params)
      flash[:success] = "#{@teacher.name}の基本情報を更新しました。"
    else
      flash[:danger] = "#{@teacher.name}の更新は失敗しました。<br>" + @parent.errors.full_messages.join("<br>")
    end
    redirect_to teachers_url
  end

  private

      def teacher_params
        params.require(:teacher).permit(:name, :email, :staff_id, :child_class, :password, :password_confirmation)
      end

      def manag_info_params
        params.require(:teacher).permit(:staff_id, :child_class)
      end
end
