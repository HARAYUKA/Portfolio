class AttendancesController < ApplicationController
  def update
    @parent = Parent.find(params[:parent_id])
    @child = @parent.children.find(params[:child_id])
    @attendance = @child.attendances.find(params[:id])
    @attendance.update_attributes(attendances_params)
    flash[:success] = "連絡帳を提出しました。"
    redirect_to @child
  end
end


private
  # 一日分の連絡帳の情報
  def attendances_params
    params.require(:child).permit(attendances: [:attendance_time, :pick_up_time, :pick_up_person, :feeling])[:attendances]
  end