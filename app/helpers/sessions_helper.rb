module SessionsHelper
  # 引数に渡されたユーザーオブジェクトでログイン
  def log_in_parent(parent)
    session[:parent_id] = parent.id
  end

  def log_in_nursery(nursery)
    session[:nursery_id] = nursery.id
  end

   # セッションと@current_userを破棄します
  def logout_parent
    session.delete(:parent_id)
    @current_parent = nil
  end

  def logout_nursery
    session.delete(:nursery_id)
    @current_nursery = nil
  end



  # 現在ログイン中のユーザーがいる場合オブジェクトを返します。
  def current_parent
    if session[:parent_id]
      @current_parent ||= Parent.find_by(id: session[:parent_id])
    end
  end

  def current_nursery
    if session[:nursery_id]
      @current_nursery ||= Nursery.find_by(id: session[:nursery_id])
    end
  end

  # 現在ログイン中のユーザーがいればtrue、そうでなければfalseを返します。
  def parent_logged_in?
    !current_parent.nil?
  end

  def nursery_logged_in?
    !current_nursery.nil?
  end

end
