class ChildrenController < ApplicationController
  # 園児作成モーダル表示
  def new
    @parent = Parent.find(params[:parent_id])
    @child = @parent.children.new
    @classrooms = Classroom.all
  end

  # 園児作成モーダルでの園児追加
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
    @child = @parent.children
  end

  # 園児情報編集モーダル更新
  def update
  end

  private

    def child_params
      params.require(:child).permit(:child_name, :age, :birthday, :gender, :classroom_id)
    end

end
