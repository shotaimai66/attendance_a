class WorksController < ApplicationController
    
    include WorksHelper
    
    def show
        @user = User.find(params[:user_id])
        @id = params[:user_id] 
        @month = params[:id]
        
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
     redirect_to user_work_path(current_user,Date.today.month)
    end

    
end
