class TeachersController < ApplicationController
  def show
    @teacher = Teacher.find(params[:id])
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

  private

      def teacher_params
        params.require(:teacher).permit(:name, :email, :password, :password_confirmation)
      end
end
