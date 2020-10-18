class ChildrenController < ApplicationController
  # 園児作成モーダル表示
  def new
    @parent = Parent.find(params[:parent_id])
    # @classroom = Classroom.new
    # @classroom.children.build
    @child = @parent.children.new
    @classrooms = Classroom.all
  end

  # 園児作成モーダルでの園児追加
  def create
    @parent = Parent.find(params[:parent_id])
    # if Classroom.create(class_params)
    #   flash[:success] = '子供を追加しました。'
    #   redirect_to @parent
    # else
    #   flash[:danger] = '登録できませんでした。'
    #   render 'parents/show'
    # end
    @child = @parent.children.new(child_params)
    if @child.save
      flash[:success] = '子供を追加しました。'
      redirect_to @parent
    else
      flash[:danger] = '登録できませんでした。'
      render 'parents/show'
    end
  end

  private

    def child_params
      params.require(:child).permit(:child_name, :age, :birthday, :gender, :classroom_id)
    end

    # def class_params
    #   params.require(:classroom).permit(:class_name, children_attributes: [:child_name, :age, :birthday, :gender])
    # end

end
