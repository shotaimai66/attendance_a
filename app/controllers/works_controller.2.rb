class WorksController < ApplicationController
    before_action :logged_in_user, only: [:show, :edit, :create, :update]
    before_action :aa, only: [:show, :edit, :create, :update]
    include WorksHelper
    
    def show
        @user = User.find(params[:user_id])
        @id = params[:user_id]
        if params[:piyo] == nil
            # params[:piyo]が存在しない(つまりデフォルト時)
            # ▼月初(今月の1日, 00:00:00)を取得します
             @date = params[:id].to_datetime
        else
            # ▼params[:piyo]が存在する(つまり切り替えボタン押下時)
            #  paramsの中身は"文字列"で送られてくるので注意
            #  文字列を時間の型に直すときはparseメソッドを使うか、
            #@date = Time.parse(params[:piyo])
            #  もしくはto_datetimeメソッドとかで型を変えてあげるといいと思います
            @date = params[:piyo].to_datetime
        end
        
    end
    
    def create
    work_name
     if @name == "出社"
         if Work.find_by(user_id: select_user.id, day: Date.today)
           Work.find_by(user_id: select_user.id, day: Date.today ).update(start_time: Time.new(Time.now.year,Time.now.month,Time.now.day,Time.new.hour,Time.now.min,00))
           flash[:success] = "今日も一日頑張りましょう！"
         else
           @work = Work.create(user_id: select_user.id, 
                         start_time: Time.new(Time.now.year,Time.now.month,Time.now.day,Time.new.hour,Time.now.min,00),
                         day: Time.now)
           flash[:success] = "今日も一日頑張りましょう！"
         end
     elsif @name == "退社"
         Work.find_by(user_id: select_user.id, day: Date.today ).update(end_time: Time.new(Time.now.year,Time.now.month,Time.now.day,Time.new.hour,Time.now.min,00))
         flash[:success] = "お疲れ様でした！"
     elsif @name == "----"
     end
     
      redirect_to user_work_path(select_user,Date.today)
    end
    
    #フォームからのクリエイト
    def create_form
        if Work.find_by(user_id: params[:user_id], day: params[:work][:day]) && params[:work][:end_time]
            work = Work.find_by(user_id: params[:user_id], day: params[:work][:day])
            work.update(end_time: params[:work][:end_time])
            flash[:success] = "更新しました。"
        elsif Work.find_by(user_id: params[:user_id], day: params[:work][:day]) && params[:work][:start_time]
            work = Work.find_by(user_id: params[:user_id], day: params[:work][:day])
            work.update(start_time: params[:work][:start_time])
            flash[:success] = "更新しました。"
            
        
        else Work.create(user_id: params[:user_id], day: params[:work][:day].to_date, start_time: params[:work][:start_time],
                        end_time: params[:work][:end_time])
            flash[:success] = "sakuseiしました。"
        end
        
         redirect_to user_work_path(select_user,params[:id])
    end
    
    def edit
        @user = User.find(params[:user_id])
        @id = params[:user_id] 
        @date = params[:piyo].to_datetime
        @works = select_user.works.all  
    end
    
    def update
            work = select_user.works.find_by(day: params[:id])
            work.update_attributes(works_params)
            flash[:success] = "更新しました。"
    redirect_to  user_work_path(select_user,params[:id])
    
    end
    
    
    private
    
    def works_params
        
        params.require(:work).permit(:start_time, :end_time, :day, :user_id)
    end
    
    def correct_user
      @user = User.find(params[:user_id])
      redirect_to(root_url) unless current_user?(@user)
    end

   
   
    
end
