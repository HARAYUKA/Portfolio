class TeachersController < ApplicationController
  before_action :set_teacher, only: [:show, :edit, :update, :destroy, :edit_manag_info, :update_manag_info, 
                                    :edit_attendance, :update_attendance, :all_children, :index_attendance, :confirm_attendance]
  before_action :logged_in_teacher, only: [:index, :show, :edit, :update, :destroy]
  before_action :correct_teacher, only: [:edit, :update]
  before_action :admin_teacher, only: [:show, :all_children]
  before_action :not_admin_teacher, only: [:edit_manag_info, :update_manag_info, :destroy]

  # 先生一覧
  def index
    @teachers = Teacher.paginate(page: params[:page], per_page: 10)
    if params[:search].present?
      @teachers = Teacher.paginate(page: params[:page]).search(params[:search]) 
    end
  end

  # 出欠園児一覧
  def show
    @classroom = Classroom.find(@teacher.classroom_id)
    # @children = Child.joins(:classroom, :attendances).where(attendances: {status_attendance: "1"})
    @attend_children = @classroom.children.joins(:attendances).where(attendances: {status_attendance: "1", worked_on: Date.today}).order(:birthday)
    @absence_children = @classroom.children.joins(:attendances).where(attendances: {status_attendance: "2", worked_on: Date.today}).order(:birthday)
  end

  # 連絡帳の返信
  def edit_attendance
    @child = Child.find(params[:child_id])
    @attendance = @child.attendances.find_by(worked_on: Date.current)
  end

  # 連絡帳の返信の更新
  def update_attendance
    @child = Child.find(params[:child_id])
    @attendance = @child.attendances.find_by(worked_on: Date.current)
    if params[:attendance][:reply_check] == "1"
      @attendance.update_attributes(edit_attendance_params)
      flash[:success] = "#{@child.child_name}の連絡帳を返信しました。"
    else
      flash[:danger] = "#{@child.child_name}の返信内容確認のチェックが入っていません。"
      redirect_to edit_attendance_teacher_url(@teacher, child_id: @child) and return
    end
    redirect_to @teacher and return
  end

  # 担当園児一覧
  def all_children
    @classroom = Classroom.find(@teacher.classroom_id)
    @all_children = @classroom.children.order(:birthday)
  end

  # 園児の連絡帳一覧
  def index_attendance
    # @classroom = Classroom.find(@teacher.classroom_id)
    @child = Child.find(params[:child_id])
    @parent = Parent.find(@child.parent_id)
    # indexを最初に開いた時にはまだparams[:month]は飛んできていない為下記の条件分岐が必要となる。
    if params[:month].blank?
      @month = Date.today
    else
      @month = params[:month].to_date
    end
    @attendances = @child.attendances.where(worked_on: @month.all_month).where.not(worked_on: nil)
  end

  # 園児の連絡帳の確認ボタン
  def confirm_attendance
    @child = Child.find(params[:child_id])
    @attendance = @child.attendances.find(params[:attendance_id])
  end

  # 先生ユーザー作成
  def new
    @teacher = Teacher.new
  end

  # 先生ユーザー追加
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

  # 基本情報編集
  def edit
  end

  # 基本情報更新
  def update
    if @teacher.update_attributes(teacher_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @teacher
    else
      render :edit      
    end
  end

  # 先生の削除
  def destroy
    @teacher.destroy
    flash[:success] = "#{@teacher.name}のデータを削除しました。"
    redirect_to teachers_url
  end

  # 管理者が変更可能な保育者情報編集
  def edit_manag_info
  end

  # 管理者が変更可能な保育者情報更新
  def update_manag_info
    if @teacher.update_attributes(manag_info_params)
      flash[:success] = "#{@teacher.name}の基本情報を更新しました。"
    else
      flash[:danger] = "#{@teacher.name}の更新は失敗しました。<br>" + @parent.errors.full_messages.join("<br>")
    end
    redirect_to teachers_url
  end

  # # LINEログイン
  # def line_login
  #   @teacher = Teacher.from_omniauth(request.env["omniauth.auth"])
  #     result = @teacher.save(context: :line_login)
  #     if result
  #       log_in_teacher @teacher
  #       redirect_to @teacher
  #     else
  #       redirect_to teacher_auth_failure_path
  #     end
  # end
  
  # #認証に失敗した際の処理
  # def auth_failure 
  #   @teacher = Teacher.new
  #   render '任意のアクション'
  # end

  private

      def teacher_params
        params.require(:teacher).permit(:name, :email, :staff_id, :class_name, :password, :password_confirmation)
      end

      def manag_info_params
        params.require(:teacher).permit(:staff_id, :classroom_id)
      end

      def edit_attendance_params
        params.require(:attendance).permit(:first_snack, :amount_1_snack, :lunch_time, :amount_lunch, :second_snack, 
          :amount_2_snack,:start_afternoon_sleep, :end_afternoon_sleep, :status_at_school, :info_from_home, :info_from_school, :reply_check)
      end
end
