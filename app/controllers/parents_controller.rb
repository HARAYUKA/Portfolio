class ParentsController < ApplicationController
  before_action :set_parent, only: [:show, :edit, :update, :destroy, :edit_manag_info, :update_manag_info]
  before_action :logged_in_parent, only: [:show, :edit, :update]
  before_action :correct_parent, only: [:edit, :update]
  # before_action :not_admin_teacher, only: :destroy

  # 保護者一覧
  def index
    @parents = Parent.paginate(page: params[:page], per_page: 10)
    if params[:search].present?
      @parents = Parent.paginate(page: params[:page]).search(params[:search]) 
    end
  end

  # 園児情報一覧
  def show
    @children = @parent.children
  end

  # 親ユーザー作成
  def new
    @parent = Parent.new
  end

  # 親ユーザー追加
  def create
    @parent = Parent.new(parent_params)
    if @parent.save
      log_in_parent @parent
      flash[:success] = '新規作成に成功しました。'
      redirect_to @parent
    else
      render :new
    end
  end

  # 基本情報編集
  def edit
  end

  # 基本情報更新
  def update
    if @parent.update_attributes(parent_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @parent
    else
      render :edit      
    end
  end

  # 保護者削除
  def destroy
    @parent.destroy
    flash[:success] = "#{@parent.name}のデータを削除しました。"
    redirect_to parents_url
  end

  # 管理者のみ変更できる保護者編集ボタン
  # def edit_manag_info
  # end

  # def update_manag_info
  #   if @parent.update_attributes(manag_info_params)
  #     flash[:success] = "#{@parent.name}の基本情報を更新しました。"
  #   else
  #     flash[:danger] = "#{@parent.name}の更新は失敗しました。<br>" + @parent.errors.full_messages.join("<br>")
  #   end
  #   redirect_to parents_url
  # end

  # # LINEログイン
  # def line_login
  #   @parent = Parent.from_omniauth(request.env["omniauth.auth"])
  #     result = @parent.save(context: :line_login)
  #     if result
  #       log_in_parent @parent
  #       redirect_to @parent
  #     else
  #       redirect_to parent_auth_failure_path
  #     end
  # end
  
  # #認証に失敗した際の処理
  # def auth_failure 
  #   @parent = Parent.new
  #   render '任意のアクション'
  # end


  private

      def parent_params
        params.require(:parent).permit(:name, :email, :phone_number, :relationship, :password, :password_confirmation)
      end

      # def manag_info_params
      #   params.require(:parent).permit(:child_class)
      # end
end
