class NoticesController < ApplicationController
  before_action :set_notice, only: [:show, :edit, :update, :destroy]

  def index
    @notices = Notice.paginate(page: params[:page], per_page: 10)
  end

  def show
  end
  
  def edit
  end
  
  def update
    if @notice.update_attributes(notice_params)
      flash[:success] = "お知らせの更新に成功しました。"
      redirect_to notices_url and return
    elsif  params[:content].blank?
      flash[:danger] = "お知らせの内容を入力して下さい。"
      redirect_to edit_notice_url and return
    end
  end
  
  def new
    @notice = Notice.new
  end

  def create
  @notice = Notice.new(notice_params)
    if @notice.save
      flash[:info] = "お知らせを送信しました。"
      message = {
        type: 'text',
        text: @notice.content
      }
      client = Line::Bot::Client.new { |config| 
        config.channel_secret = Rails.application.credentials.LINE[:LINE_CHANNEL_SECRET]
        config.channel_token = Rails.application.credentials.LINE[:LINE_CHANNEL_TOKEN]  
      }
      response = client.broadcast(message)
      redirect_to notices_url
    else 
      render :new
    end
  end 
  
  def destroy
    @notice.destroy
    flash[:success] = "#{@notice.content}のデータを削除しました。"
    redirect_to notices_url
  end
  
  
  private
  
  def notice_params
      params.require(:notice).permit(:content)
  end
end
