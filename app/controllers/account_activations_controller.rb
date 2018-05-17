class AccountActivationsController < ApplicationController

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "#{user.name}ようこそProgra:へ！"
      redirect_to user
    else
      flash[:danger] = "アカウント有効化リンクが無効です。"
      redirect_to root_url
    end
  end
end