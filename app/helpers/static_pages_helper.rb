module StaticPagesHelper


    def work_name
        if Work.find_by_id(current_user.id).nil?
          @name = "出社"
        elsif Work.find_by_id(current_user.id).end_time
          @name = "----"
        elsif Work.find_by_id(current_user.id).start_time
          @name = "退社"
        else
          @name = "出社"
        end
    end
    
    def start_time(a)
        Work.find_by(day: a, user_id: current_user.id) && Work.find_by(day: a, user_id: current_user.id).start_time
    end
    
    
    def end_time(a)
      Work.find_by(day: a, user_id: current_user.id) && Work.find_by(day: a, user_id: current_user.id).end_time
    end
    
    
    def current_month_first
      "#{params[:id]} / #{Date.new(2018,params[:id].to_i(10),1).beginning_of_month.day}"
    end
    
    def current_month_end
      "#{params[:id]} / #{Date.new(2018,params[:id].to_i(10),1).end_of_month.day}"
    end
   
    
end
