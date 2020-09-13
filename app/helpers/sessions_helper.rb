module SessionsHelper
  # 引数に渡されたユーザーオブジェクトでログイン
  def log_in_parent(parent)
    session[:parent_id] = parent.id
  end

  def log_in_teacher(teacher)
    session[:teacher_id] = teacher.id
  end

  # 永続的セッションを記憶します（Userモデルを参照）
  def remember(parent)
    parent.remember
    cookies.permanent.signed[:parent_id] = parent.id
    cookies.permanent[:remember_token] = parent.remember_token
  end

  def remember(teacher)
    teacher.remember
    cookies.permanent.signed[:teacher_id] = teacher.id
    cookies.permanent[:remember_token] = teacher.remember_token
  end

  # 永続的セッションを破棄します
  def forget(parent)
    parent.forget
    cookies.delete(:parent_id)
    cookies.delete(:remember_token)
  end

  def forget(teacher)
    teacher.forget
    cookies.delete(:teacher_id)
    cookies.delete(:remember_token)
  end

   # セッションと@current_userを破棄します
  def logout_parent
    forget(current_parent)
    @current_parent = nil
  end

  def logout_teacher
    forget(current_teacher)
    @current_teacher = nil
  end


  # 一時的セッションにいるユーザーを返します。
  # それ以外の場合はcookiesに対応するユーザーを返します。
  def current_parent
    if (parent_id = session[:parent_id])
      @current_parent ||= Parent.find_by(id: parent_id)
    elsif (parent_id = cookies.signed[:parent_id])
      parent = Parent.find_by(id: parent_id)
      if parent && parent.authenticated?(cookies[:remember_token])
        log_in_parent parent
        @current_parent = parent
      end
    end
  end

  def current_teacher
    if (teacher_id = session[:teacher_id])
      @current_teacher ||= Teacher.find_by(id: teacher_id)
    elsif (teacher_id = cookies.signed[:teacher_id])
      teacher = Teacher.find_by(id: teacher_id)
      if teacher && teacher.authenticated?(cookies[:remember_token])
        log_in_teacher teacher
        @current_teacher = teacher
      end
    end
  end

  # 渡されたユーザーがログイン済みのユーザーであればtrueを返します。
  def current_parent?(parent)
    parent == current_parent
  end

  def current_teacher?(teacher)
    teacher == current_teacher
  end

  # 現在ログイン中のユーザーがいればtrue、そうでなければfalseを返します。
  def parent_logged_in?
    !current_parent.nil?
  end

  def teacher_logged_in?
    !current_teacher.nil?
  end

end
