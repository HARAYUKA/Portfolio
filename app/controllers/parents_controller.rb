class ParentsController < ApplicationController
  before_action :set_parent, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_parent, only: [:index, :show, :edit, :update, :destroy]
  before_action :correct_parent, only: [:edit, :update]
  before_action :admin_teacher, only: :destroy


  def index
    @parents = Parent.paginate(page: params[:page], per_page: 10)
  end

  def show
  end

  def new
    @parent = Parent.new
  end

  def create
    @parent = Parent.new(parent_params)
    if @parent.save
      flash[:success] = '新規作成に成功しました。'
      redirect_to @parent
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @parent.update_attributes(parent_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @parent
    else
      render :edit      
    end
  end

  def destroy
    @parent.destroy
    flash[:success] = "#{@parent.name}のデータを削除しました。"
    redirect_to parents_url
  end

  private

      def parent_params
        params.require(:parent).permit(:name, :email, :child_name, :child_class, :relationship, :password, :password_confirmation)
      end
end
