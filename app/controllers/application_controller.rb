class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private

    # ユーザーのログインを確認する
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
    end
    # 管理者もしくはカレントユーザー以外の人の処理
    def aa
      #paramsは文字列で帰ってくることを忘れない（数値にして比較）
      if current_user.id != params[:user_id].to_i && !current_user.admin?
        store_location
        flash[:danger] = "他のユーザー情報は閲覧できません。"
        redirect_to root_path
      end
    end
    
    #存在するユーザーかどうか検証
    def user_being
      unless User.exists?(id: params[:user_id])
        flash[:danger] = "該当IDをもつユーザーは存在しません。"
        redirect_to root_path
      end
    end
   
end