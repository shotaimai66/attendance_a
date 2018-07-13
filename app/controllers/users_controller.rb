class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:destroy, :edit_basic_info, :update_basic_info]
  
  include StaticPagesHelper

  def index
    @users = User.where(activated: true).paginate(page: params[:page]).search(params[:search])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    if User.exists?
    @user = User.new(name: params[:user][:name],
             email: params[:user][:email],
             team: params[:user][:email],
             password:              params[:user][:password],
             password_confirmation: params[:user][:password_confirmation],
             activated: true,
             activated_at: Time.zone.now)
    else
    @user = User.new(name: params[:user][:name],
             email: params[:user][:email],
             team: params[:user][:email],
             specified_work_time: Time.zone.local(2018, 6, 30, 8,0),
             basic_work_time: Time.zone.local(2018, 6, 30, 7,30),
             password:              params[:user][:password],
             password_confirmation: params[:user][:password_confirmation],
             activated: true,
             activated_at: Time.zone.now,
             admin: true)
    end         
      @user.save
      log_in @user
       flash[:info] = "アカウント登録が完了しました。"
       redirect_to user_work_path(@user,Date.today)
    
    
  end

  def edit
    @user = User.find(params[:id])
    @month = Date.today.month
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "プロフィールを更新しました！"
      redirect_to user_work_path(current_user,Date.today)
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "アカウントを削除しました。"
    redirect_to users_url
  end
  
  def edit_basic_info
    
  end
  
  def update_basic_info
   @user = User.find(1)
    if @user.update_attributes(users_basic_params)
      flash[:success] = "基本情報を更新しました。"
      redirect_to user_work_path(current_user,Date.today)
    else
      render 'edit'
    end
    
  end
 
  

  private

    def user_params
      params.require(:user).permit(:name, :email, :team, :password,
                                   :password_confirmation)
    end
    
    def users_basic_params
      params.require(:user).permit(:specified_work_time, :basic_work_time)
    end

    # beforeフィルター

    # 正しいユーザーかどうかを確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # 管理者かどうかを確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
