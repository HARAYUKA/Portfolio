class SessionsController < ApplicationController
  def parent_login
  end

  def nursery_login
  end

  def parent_create
    parent = Parent.find_by(email: params[:session][:email].downcase)
    if parent && parent.authenticate(params[:session][:password])
      log_in_parent parent
      redirect_to parent
    else
      flash.now[:danger] = '認証に失敗しました。'
      render :parent_login
    end
  end

  def nursery_create
    nursery = Nursery.find_by(email: params[:session][:email].downcase)
    if nursery && nursery.authenticate(params[:session][:password])
      log_in_nursery nursery
      redirect_to nursery
    else
      flash.now[:danger] = '認証に失敗しました。'
      render :nursery_login
    end
  end

end
