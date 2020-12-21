class TeachersController < ApplicationController
  before_action :set_teacher, only: [:show, :edit, :update, :destroy, :edit_manag_info, :update_manag_info, :edit_attendance, :update_attendance]
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
    @classroom = Classroom.find(@teacher.classroom_id)
    # @children = Child.joins(:classroom, :attendances).where(attendances: {status_attendance: "1"})
    @children = @classroom.children.joins(:attendances).where(attendances: {status_attendance: "1", worked_on: Date.today}).order(:birthday)
  end

  def edit_attendance
    @child = Child.find(params[:child_id])
    @attendance = @child.attendances.find_by(worked_on: Date.current)
  end

  def update_attendance
    @child = Child.find(params[:child_id])
    @attendance = @child.attendances.find_by(worked_on: Date.current)
    if @attendance.update_attributes(edit_attendance_params)
      flash[:success] = "#{@child.child_name}の連絡帳を返信しました。"
    else
      flash[:danger] = "#{@child.child_name}の連絡帳を返信出来ませんでした。。"
    end
    redirect_to teacher_url(@teacher)
  end

  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.new(teacher_params)
    if @teacher.save
      log_in_teacher @teacher
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

      def edit_attendance_params
        params.require(:attendance).permit(:first_snack, :amount_1_snack, :lunch_time, :amount_lunch, :second_snack, 
          :amount_2_snack,:start_afternoon_sleep, :end_afternoon_sleep, :status_at_school, :info_from_home, :info_from_school)
      end
end
