class WorksController < ApplicationController
    before_action :logged_in_user, only: [:show, :edit, :create, :update]
    before_action :aa, only: [:show, :edit, :create, :update]
    before_action :user_being, only: [:show, :edit, :create, :update]
    include WorksHelper
    
    def show
        @work = Work.new
        @month_work = select_user.works.find_by(day: params[:id])
        @works = Work.where(checker: current_user.name)
        @user = User.find(params[:user_id])
        @id = params[:user_id]
        if params[:piyo]
            @date = params[:piyo].to_datetime
        else
            @date = params[:id].to_datetime
        end
        #表示する編集ページのユーザーの一月分のレコードが存在するか検証
        #レコードが存在しない場合は新規作成（create）
        days = (Date.new(@date.year,@date.month).all_month) 
        days.each do |day|
            unless select_user.works.find_by(day: day)
                Work.create(user_id: params[:user_id], day: day)
            end
        end
        if params[:piyo]  
           @date = params[:piyo].to_datetime
        
        elsif params[:id].to_datetime.month != Date.today.month
              @date = params[:id].to_datetime
              
        else
              @date = Date.today
            
        end
        
    end
    
    def create
    work_name
        if @name == "出社"#出社ボタンが表示されている時
            if Work.find_by(user_id: select_user.id, day: Date.today)
            #(update)出社ボタン押下の日付のレコードが存在したら、それを更新
            #秒以下を切り捨てるように更新設定
                Work.find_by(user_id: select_user.id, day: Date.today ).update(start_time: Time.new(Time.now.year,Time.now.month,Time.now.day,Time.new.hour,Time.now.min,00))
                select_user.update(working:"出社中")
                flash[:success] = "今日も一日頑張りましょう！"
            else
            #（creata）存在しなければ、新しくレコード作成
            #秒以下を切り捨てるように更新設定
                @work = Work.create(user_id: select_user.id, 
                        start_time: Time.new(Time.now.year,Time.now.month,Time.now.day,Time.new.hour,Time.now.min,00),
                        day: Time.now)
                flash[:success] = "今日も一日頑張りましょう！"
            end
        elsif @name == "退社"#退社ボタンが表示されている時
            Work.find_by(user_id: select_user.id, day: Date.today ).update(end_time: Time.new(Time.now.year,Time.now.month,Time.now.day,Time.new.hour,Time.now.min,00))
            select_user.update(working:"")
            flash[:success] = "お疲れ様でした！"
        elsif @name == "----"
        end
        #更新したワークのユーザーのトップページへ
        redirect_to user_work_path(select_user,Date.today)
    end
    
    def edit
        @user = User.find(params[:user_id])
        @id = params[:user_id] 
        @date = params[:piyo].to_datetime
        #表示する編集ページのユーザーの一月分のレコードが存在するか検証
        #レコードが存在しない場合は新規作成（create）
        days = (Date.new(@date.year,@date.month).all_month) 
        days.each do |day|
            unless select_user.works.find_by(day: day)
                Work.create(user_id: params[:user_id], day: day)
            end
        end
        
    end
    
    def update
        # require 'ruby-debug'; debugger; true;
        works_params.each do |id, item|
            work = Work.find_by(id: id)
            if item.fetch("start_time").present?
                start_time = Time.parse("#{work.day} #{item.fetch("start_time")}") - 9.hour
            else
                start_time = nil
            end
            if item.fetch("end_time").present?
                if item[:check_tomorrow] == "true"
                    end_time = Time.parse("#{work.day} #{item.fetch("end_time")}").tomorrow - 9.hour
                else
                    end_time = Time.parse("#{work.day} #{item.fetch("end_time")}") - 9.hour 
                end
            else
                end_time = nil
            end
            
            work.update(starttime_change: start_time, endtime_change: end_time, note: item[:note], work_check: item[:work_check], check_tomorrow: item[:check_tomorrow])
        end
        flash[:success] = "勤怠変更を申請しました！"
        
    #セレクトユーザーの編集した月ページへ
    redirect_to  user_work_path(select_user,params[:piyo])
    end
    
    
    def create_overwork
        @work=select_user.works.find_by(day: params[:work][:day])
        if params[:work][:check_box]=="true"
            date_tomorrow=time_change.tomorrow - 9.hours
            @work.update_attributes(create_overwork_params)
            @work.update(endtime_plan: date_tomorrow)
        else
            @work.update_attributes(create_overwork_params)
            @work.update(endtime_plan: time_change-9.hours)
        end
        flash[:success] = "申請しました！"
        redirect_to  user_work_path(select_user,Date.today)
        
    end
    
    def update_overwork
        update_overwork_params.each do |id, item|
            work = Work.find(id)
            if item.fetch("check_box")=="true"
                work.update_attributes(over_check: item.fetch("over_check"))  
            end
        end
        flash[:success] = "申請を更新しました!(残業申請)"
        #セレクトユーザーの編集した月ページへ
        redirect_to  user_work_path(current_user,Date.today)
        
    end
    
    def create_monthwork
        if params[:work]&&!params[:work][:piyo].blank?
            @date = params[:work][:piyo].to_datetime
        else
            @date = params[:id].to_datetime
        end
        day = Date.new(@date.year,@date.month)
                current_user.works.find_by(day: day).update(month_check: params[:work][:month_check])
        flash[:success] = "申請しました!(１ヶ月分)"
        redirect_to  user_work_path(select_user,Date.today)
    end
    
    def update_monthwork
        update_monthwork_params.each do |id, item|
            work = Work.find(id)
            if item.fetch("check_box")=="true"
                work.update_attributes(month_check: item.fetch("month_check"))  
            end
        end
        flash[:success] = "申請を更新しました!(１ヶ月分)"
    #セレクトユーザーの編集した月ページへ
    redirect_to  user_work_path(current_user,Date.today)
    
    end
    
    def update_changework
        update_changework_params.each do |id, item|
            work = Work.find_by(id: id)
            if item[:work_check] == "承認" && item.fetch("check_box")=="true"
                work.update(work_check: item[:work_check], start_time: work.starttime_change, end_time: work.endtime_change)
            elsif item.fetch("check_box")=="true"
                work.update(item).update(check_box: "false")
            end
        end
        flash[:success] = "申請を更新しました!（勤怠変更）"
    #セレクトユーザーの編集した月ページへ
    redirect_to  user_work_path(current_user,Date.today)
    
    end
    
    
    
    
    
    
     private
    def works_params
        params.permit(works: [:start_time, :end_time, :note, :work_check, :check_tomorrow])[:works]
    end
    
    def create_overwork_params
        params.require(:work).permit(:endtime_plan, :work_content, :over_check, :day)
    end
    
    def update_monthwork_params
        params.permit(works: [:month_check, :check_box])[:works]
    end
    
    def update_overwork_params
        params.permit(works: [:over_check, :check_box])[:works]
    end
    
    def update_changework_params
        params.permit(works: [:work_check, :check_box])[:works]
    end
    
    def time_change
        day=params[:work][:day].to_datetime
        time=params[:work][:endtime_plan].to_datetime
        Time.new(day.year,day.month,day.day,time.hour,time.min,time.sec)
    end
    
    def time_change_work
        day=params[:work][:day].to_datetime
        time=params[:work][:endtime_plan].to_datetime
        Time.new(day.year,day.month,day.day,time.hour,time.min,time.sec)
    end
    
  
    

   
   
    
end
