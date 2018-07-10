class AccountActivationsController < ApplicationController

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      message  = "#{user.name}さん アカウント認証が完了しました。"
      flash[:success] = message
      redirect_to user_work_path(user,Date.today)
    else
      flash[:danger] = "アカウント有効化リンクが無効です。"
      redirect_to root_url
    end
  end
end