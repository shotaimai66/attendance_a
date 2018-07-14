module WorksHelper
    
    def work_name
        if select_user.works.find_by(day: Date.today).nil?
          @name = "出社"
        elsif select_user.works.find_by(day: Date.today).end_time
          @name = "----"
        elsif select_user.works.find_by(day: Date.today).start_time
          @name = "退社"
        else
          @name = "出社"
        end
    end
    
    def start_time(a)
        Work.find_by(day: a, user_id: select_user.id) && Work.find_by(day: a, user_id: select_user.id).start_time
    end
    
    
    def end_time(a)
      Work.find_by(day: a, user_id: select_user.id) && Work.find_by(day: a, user_id: select_user.id).end_time
    end
    
    def total_time(y,m)
      days = (Date.new(y,m).all_month)
      days.map do |day|
        if start_time(day)&&end_time(day)
          (end_time(day)-start_time(day))/60/60
        else
          0
        end
      end
    end
    
    def total_works_time(y,m)
      select_user.works.where(day: Time.new(y,m).all_month).select("end_time").count * basic_time
    end
    
   
    
    def start_time_change(key)
      if select_user.works.find_by(day: key)
        select_user.works.find_by(day: key).start_time
      end
    end
    
    def end_time_change(key)
      if select_user.works.find_by(day: key)
        select_user.works.find_by(day: key).end_time
      end
    end
    
    def select_user
      User.find(params[:user_id])
    end
    
    def specified_time
      if User.find(1).specified_work_time
        BigDecimal(((User.find(1).specified_work_time-User.find(1).specified_work_time.beginning_of_day)/60/60).to_s).round(3).to_f
      end
    end
    
    def basic_time
      if User.find(1).basic_work_time
        BigDecimal(((User.find(1).basic_work_time-User.find(1).basic_work_time.beginning_of_day)/60/60).to_s).round(3).to_f
      end
    end
    
    
end
