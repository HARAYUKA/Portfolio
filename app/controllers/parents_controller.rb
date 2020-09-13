class ParentsController < ApplicationController
  before_action :set_parent, only: [:show, :edit, :update]
  before_action :logged_in_parent, only: [:show, :edit, :update]
  before_action :correct_parent, only: [:edit, :update]


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

  private

      def parent_params
        params.require(:parent).permit(:name, :email, :password, :password_confirmation)
      end

      # paramsハッシュからユーザーを取得します。
      def set_parent
        @parent = Parent.find(params[:id])
      end

      # ログイン済みのユーザーか確認します。
      def logged_in_parent
        unless parent_logged_in?
          flash[:danger] = "ログインしてください。"
          redirect_to login_url
        end
      end

      # アクセスしたユーザーが現在ログインしているユーザーか確認します。
      def correct_parent
        @parent = Parent.find(params[:id])
        redirect_to(root_url) unless @parent == current_parent
      end

end
