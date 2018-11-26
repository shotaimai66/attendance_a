class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:destroy, :edit_basic_info, :update_basic_info, :index]
  require 'csv'
  include StaticPagesHelper

  def index
    @users = User.activated.paginate(page: params[:page]).search(params[:search])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    # admin　ユーザー一覧からのCSVインポート
    if params[:commit] == "CSVをインポート"
      if params[:users_file].content_type == "text/csv"
          registered_count = import_users
          unless @errors.count == 0
            flash[:danger] = "#{@errors.count}件登録に失敗しました"
          end
          unless registered_count == 0
            flash[:success] = "#{registered_count}件登録しました"
          end
          redirect_to users_url(error_users: @errors)
      else
        flash[:danger] = "CSVファイルのみ有効です"
        redirect_to users_url
      end
    else
      @user = User.new(user_params)
      if @user.save
        log_in @user
        redirect_to user_work_path(@user,Date.today)
      else
        render 'new'
      end
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
      redirect_to users_url
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
    send_data render_to_string, filename: "#{current_user.name}_#{params[:date].to_time.strftime("%Y年 %m月")}.csv", type: :csv
  end
  
  
  def working_users
    @users = User.activated.working.paginate(page: params[:page]).search(params[:search])
  end
  
  
  

  private
    # CSVインポート
    def import_users
      # 登録処理前のレコード数
      current_user_count = ::User.count
      users = []
      @errors = []
      # windowsで作られたファイルに対応するので、encoding: "SJIS"を付けている
      CSV.foreach(params[:users_file].path, headers: true) do |row|
        user = User.new({ id: row["id"], name: row["name"], email: row["email"], team: row["team"], worker_number: row["worker_number"], worker_id: row["worker_id"], basic_work_time: row["basic_work_time"], 
                              d_start_worktime: row["d_start_worktime"], d_end_worktime: row["d_end_worktime"], sv: row["sv"], admin: row["admin"], password: row["password"], activated: "true"})
        if user.valid?
            users << ::User.new({id: row["id"], name: row["name"], email: row["email"], team: row["team"], worker_number: row["worker_number"], worker_id: row["worker_id"], basic_work_time: row["basic_work_time"], 
                              d_start_worktime: row["d_start_worktime"], d_end_worktime: row["d_end_worktime"], sv: row["sv"], admin: row["admin"], password: row["password"], activated: "true"})
        else
          @errors << user.errors.inspect
          Rails.logger.warn(user.errors.inspect)
        end
      end
      # importメソッドでバルクインサートできる
      ::User.import(users)
      # 何レコード登録できたかを返す
      ::User.count - current_user_count
    end

    def user_params
      if User.exists?
        params.require(:user).permit(:name, :email, :team, :password,
                                    :activated, :activated_at,
                                      :password_confirmation,
                                      :worker_number,
                                      :worker_id,
                                      :basic_work_time,
                                      :d_start_worktime,
                                      :d_end_worktime)
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
