class AttendancesController < ApplicationController
  def update
    @parent = Parent.find(params[:parent_id])
    @child = @parent.children.find(params[:child_id])
    @attendance = @child.attendances.find(params[:id])
    @attendance.update_attributes(attendances_params)
    flash[:success] = "#{@child.child_name}の連絡帳を提出しました。"
    redirect_to @parent
  end
end


private
  # 一日分の連絡帳の情報
  def attendances_params
    params.require(:attendance).permit(:worked_on, :status_attendance, :attendance_time, :pick_up_time, :pick_up_person, :feeling, :dinner_time, 
    :amount_dinner, :morning_time, :amount_morning, :first_snack, :amount_1_snack, :lunch_time, :amount_lunch, 
    :second_snack, :amount_2_snack, :toilet_time, :toilet_status, :start_night_sleep, :end_night_sleep, :start_afternoon_sleep, 
    :end_afternoon_sleep, :status_at_home, :status_at_school, :info_from_home, :info_from_school)
  end