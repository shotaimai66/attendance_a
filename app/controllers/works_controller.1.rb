class WorksController < ApplicationController
    
    include WorksHelper
    
    def show
        @user = User.find(params[:user_id])
        @id = params[:user_id]
        if params[:piyo] == nil
            # params[:piyo]が存在しない(つまりデフォルト時)
            # ▼月初(今月の1日, 00:00:00)を取得します
             @date = Date.today
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
         @work = Work.create(user_id: current_user.id, 
                         start_time: Time.now,
                         day: Time.now)
     elsif @name == "退社"
         Work.find_by(user_id: current_user.id, day: Date.today ).update(end_time: Time.now)
     elsif @name == "----"
     end
      redirect_to user_work_path(current_user,Date.today)
    end
    
    def edit
        @user = User.find(params[:user_id])
        @id = params[:user_id] 
        @date = params[:piyo].to_datetime
        @works = current_user.works.all       
    end
    
    def update
            works_params.tap do |id, work_param|
            work = current_user.works.find_by(day: Date.parse("2018-06-20"))
            work.update_attributes(work_param)
            work
    end
    redirect_to  user_work_path(current_user,Date.today)
    
    end
    
    
    private
    
    def works_params
        params.permit(works: [:start_time, :end_time])[:works]
    end

   
   
    
end
