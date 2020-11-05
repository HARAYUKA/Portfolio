class ChildrenController < ApplicationController
  # before_action :set_one_month, only: :show

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

  # 園児情報詳細画面
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

  private

    def child_params
      params.require(:child).permit(:child_name, :age, :birthday, :gender, :classroom_id)
    end

    # @attendanceにデータがあるかどうか
    def find_attendance?
      @attendance = @child.attendances.find_by(worked_on: @day)
    end

end
