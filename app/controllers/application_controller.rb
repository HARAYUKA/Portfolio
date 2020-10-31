class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  $days_of_the_week = %w{日 月 火 水 木 金 土}

  # paramsハッシュからユーザーを取得します。
  def set_parent
    @parent = Parent.find(params[:id])
  end

  def set_teacher
    @teacher = Teacher.find(params[:id])
  end

  # ログイン済みのユーザーか確認します。
  def logged_in_parent
    unless parent_logged_in?
      store_location
      flash[:danger] = "ログインしてください。"
      redirect_to parent_login_url
    end
  end

  def logged_in_teacher
    unless teacher_logged_in?
      store_location
      flash[:danger] = "ログインしてください。"
      redirect_to teacher_login_url
    end
  end

  # 園の管理者かどうかを確認
  def admin_teacher
    if current_teacher != nil # teacherだったら下の処理
      redirect_to root_url unless current_teacher.admin? # teacherがadminの場合の処理
    else # teacherではなかったら下の処理
      flash[:danger] = "権限がありません。"
      redirect_to root_url
    end
  end

  # アクセスしたユーザーが現在ログインしているユーザーか確認します。
  def correct_parent
    redirect_to(root_url) unless current_parent?(@parent)
  end

  def correct_teacher
    redirect_to(root_url) unless current_teacher?(@teacher)
  end

  # # 1ヶ月分のデータの存在を確認・セット
  # def set_one_month 
  #   @first_day = params[:date].nil? ?
  #   Date.current.beginning_of_month : params[:date].to_date
  #   @last_day = @first_day.end_of_month
  #   one_month = [*@first_day..@last_day] # 対象の月の日数を代入
  #   # 園児に紐付く一ヶ月分のレコードを検索し取得
  #   @attendances = @child.attendances.where(worked_on: @first_day..@last_day).order(:worked_on)

  #   unless one_month.count == @attendances.count # それぞれの件数（日数）が一致するか評価
  #     ActiveRecord::Base.transaction do # トランザクションを開始
  #       # 繰り返し処理により、1ヶ月分の連絡帳データを生成
  #       one_month.each { |day| @child.attendances.create!(worked_on: day) }
  #     end
  #     @attendances = @child.attendances.where(worked_on: @first_day..@last_day).order(:worked_on)
  #   end

  # rescue ActiveRecord::RecordInvalid # トランザクションによるエラーの分岐
  #   flash[:danger] = "ページ情報の取得に失敗しました、再アクセスしてください。"
  #   redirect_to root_url
  # end
end
