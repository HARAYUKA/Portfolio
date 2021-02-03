class ChildrenController < ApplicationController
  before_action :logged_in_parent, only: [:new, :create, :edit, :update, :show]
  before_action :not_admin_teacher, only: [:all, :destroy_from_admin, :edit_class, :update_class]

  # 園児一覧
  def index
    @children = Child.paginate(page: params[:page], per_page: 10)
    if params[:search].present?
      @children = Child.paginate(page: params[:page]).search(params[:search]) 
    end
  end
  
  # 園児追加モーダル表示
  def new
    @parent = Parent.find(params[:parent_id])
    @child = @parent.children.new
    @classrooms = Classroom.all
  end

  # 園児追加モーダルでの園児作成
  def create
    @parent = Parent.find(params[:parent_id])
    @child = @parent.children.new(child_params)
    if @child.save
      flash[:success] = '子供を追加しました。'
      redirect_to @parent
    else
      flash.now[:danger] = '登録できませんでした。'
      render 'parents/show'
    end
  end

  # 園児情報編集モーダル
  def edit
    @parent = Parent.find(params[:parent_id])
    @child = @parent.children.find(params[:id])
    @classrooms = Classroom.where(id: @child.classroom_id)
  end

  # 園児情報編集モーダル更新
  def update
    @parent = Parent.find(params[:parent_id])
    @child = @parent.children.find(params[:id])
    if @child.update_attributes(child_params)
      flash[:success] = "園児情報を更新しました。"
      redirect_to @parent
    else
      render :edit 
    end
  end

  # 園児連絡帳提出画面
  def show
    @parent = Parent.find(params[:parent_id])
    @child = @parent.children.find(params[:id])
    if params[:date].blank?
      @day = Date.today
    else
      @day = params[:date].to_date
    end
    unless find_attendance?
      @attendance = @child.attendances.create # @attendanceにデータがなかった場合に新規でデータ作成
    end
  end

  # 管理者のみ表示可能な園児一覧
  def all
    @children = Child.paginate(page: params[:page], per_page: 10).order(:classroom_id)
    if params[:search].present?
      @children = Child.paginate(page: params[:page]).search(params[:search]) 
    end
  end

  # 管理者による園児削除
  def destroy_from_admin
    @child = Child.find(params[:id])
    @child.destroy
    flash[:success] = "#{@child.child_name}のデータを削除しました。"
    redirect_to all_url
  end

  # 管理者による園児クラス編集
  def edit_class
    @child = Child.find(params[:id])
  end

  # 管理者による園児クラス更新
  def update_class
    @child = Child.find(params[:id])
    if @child.update_attributes(class_params)
      flash[:success] = "園児情報を更新しました。"
      redirect_to all_url
    else
      render :edit_class 
    end
  end

  private
    # 園児情報
    def child_params
      params.require(:child).permit(:child_name, :age, :birthday, :gender, :classroom_id)
    end

    # @attendanceにデータがあるかどうか
    def find_attendance?
      @attendance = @child.attendances.find_by(worked_on: @day)
      # @attendance = Attendance.find_by(child_id: @child.id, worked_on: @day.to_s)
    end

    # クラス情報
    def class_params
      params.require(:child).permit(:classroom_id)
    end

end
