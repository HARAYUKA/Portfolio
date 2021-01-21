class AttendancesController < ApplicationController
  # 園児連絡帳更新処理
  def update
    @parent = Parent.find(params[:parent_id])
    @child = @parent.children.find(params[:child_id])
    @attendance = @child.attendances.find(params[:id])
    ActiveRecord::Base.transaction do
      if params[:attendance][:send_check] == "1"
        # 登園予定の処理。既に欠席で更新されていた場合のattendanceの項目「欠席理由」をnilにしてStrongParameterの項目を更新
        if params[:attendance][:status_attendance] == "1"
          params[:attendance][:reason_of_absence] = nil
          @attendance.reply_check = false
          @attendance.update_attributes!(attendances_params)
          flash[:success] = "#{@child.child_name}の連絡帳を出席予定で提出しました。"
        # 欠席の処理。既に登園予定で更新されていた場合のattendanceの項目をnilにする。項目が多い為、特定の項目以外をnilにする、という処理
        elsif params[:attendance][:status_attendance] == "2"
          attendance_keys = @attendance.attributes.stringify_keys.keys # attendance_keysに@attendanceの項目のhashキーをシンボルから文字列に変え（例：{a: 1} → {"a"=>1}）、キーだけを代入
          attendance_hash = {status_attendance: "2", send_check: "1"} # attendance_hashに「登園予定情報: 欠席」というhashを代入
          no_update = ["child_id", "id", "created_at", "updated_at", "status_attendance", "send_check", "reply_check"] # nilにするとまずいattendanceの基本項目を代入
          attendance_keys.each do |keys| # 文字列に変えた@attendanceの項目のhashキーをeachで取り出す
            if keys == "worked_on" || keys == "reason_of_absence" # keysが「日付」または「欠席理由」の場合
              attendance_hash[keys] = params[:attendance][:"#{keys}"]
            elsif no_update.exclude?(keys) # 上記以外のキーの場合、no_updateの項目にkeysが含まれていなければtrueを返す
              attendance_hash[keys] = nil
            end
          end
          @attendance.update_attributes!(attendance_hash)
          flash[:success] = "#{@child.child_name}の連絡帳を欠席で提出しました。"
        end
      else
        flash[:danger] = "提出内容確認のチェックが入っていません。"
        redirect_to parent_child_url(@parent, @child) and return
      end
    end
    redirect_to @parent and return
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = "無効な入力データがあった為、提出をキャンセルしました。"
    redirect_to @parent and return
  end

  # 連絡帳一覧
  def index
    @parent = Parent.find(params[:parent_id])
    @child = @parent.children.find(params[:child_id])
    # indexを最初に開いた時にはまだparams[:month]は飛んできていない為下記の条件分岐が必要となる。
    if params[:month].blank?
      @month = Date.today
    else
      @month = params[:month].to_date
    end
    @attendances = @child.attendances.where(worked_on: @month.all_month).where.not(worked_on: nil)
  end

  # 連絡帳確認ボタン
  def confirm_attendance
    @parent = Parent.find(params[:parent_id])
    @child = @parent.children.find(params[:child_id])
    @attendance = @child.attendances.find(params[:id])
  end

end


private
  # 一日分の連絡帳の情報
  def attendances_params
    params.require(:attendance).permit(:worked_on, :status_attendance, :attendance_time, :pick_up_time, :pick_up_person, :feeling, :temp,
    :dinner_time, :amount_dinner, :morning_time, :amount_morning, :toilet_time, :toilet_status, :start_night_sleep, :end_night_sleep, 
    :status_at_home, :info_from_home, :reason_of_absence, :send_check, :reply_check)
  end