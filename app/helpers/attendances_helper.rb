module AttendancesHelper
  # 時間と分をそれぞれ分けてメソッドを定義
  def format_hour(time)
    format("%.2d", ((time.hour)))
  end
  
  def format_min(time)
    format("%.2d", (((time.min) / 15) * 15))
  end
end
