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
    @user = User.new(user_params)
    if @use.save
      log_in @user
      redirect_to user_work_path(@user,Date.today)
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    @month = Date.today.month
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "アカウントを更新しました。"
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
  

  def csv_output
    date=params[:date].to_datetime
    @works = current_user.works.where(day: date.beginning_of_month..date.end_of_month )
    send_data render_to_string, filename: "user.csv", type: :csv
  end
  
                
                
                
                
                
                def sample
                end
                
                def change_session_year
                 session[:year] = 2013
                 render nothing: true
                end

  

  private

    def user_params
      if User.exists?
        params.require(:user).permit(:name, :email, :team, :password,
                                    :activated, :activated_at,
                                      :password_confirmation)
       else
        params.require(:user).permit(:name, :email, :team, :password,
                                    :activated, :activated_at,
                                    :password_confirmation, :specified_work_time,
                                    :basic_work_time, :admin)
      end
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
