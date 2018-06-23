class SessionsController < ApplicationController

  def new
  end

  def create
    month = Date.today
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        params[:month] = Date.today.month
        redirect_to user_work_path(user,month)
        
      else
        message  = "アカウントが有効化されていません。 "
        message += "Prograから送られてきたメールのリンクをご確認ください！"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'メールアドレスとパスワードが無効な組み合わせです。'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end