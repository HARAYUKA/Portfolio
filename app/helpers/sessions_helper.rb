module SessionsHelper
  # 引数に渡されたユーザーオブジェクトでログイン
  def log_in_parent(parent)
    session[:parent_id] = parent.id
  end

  def log_in_teacher(teacher)
    session[:teacher_id] = teacher.id
  end

   # セッションと@current_userを破棄します
  def logout_parent
    session.delete(:parent_id)
    @current_parent = nil
  end

  def logout_teacher
    session.delete(:teacher_id)
    @current_teacher = nil
  end



  # 現在ログイン中のユーザーがいる場合オブジェクトを返します。
  def current_parent
    if session[:parent_id]
      @current_parent ||= Parent.find_by(id: session[:parent_id])
    end
  end

  def current_teacher
    if session[:teacher_id]
      @current_teacher ||= Teacher.find_by(id: session[:teacher_id])
    end
  end

  # 現在ログイン中のユーザーがいればtrue、そうでなければfalseを返します。
  def parent_logged_in?
    !current_parent.nil?
  end

  def teacher_logged_in?
    !current_teacher.nil?
  end

end
