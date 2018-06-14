module WorksHelper
    
    def work_name
        if Work.find_by(day: Date.today).nil?
          @name = "出社"
        elsif Work.find_by(day: Date.today).end_time
          @name = "----"
        elsif Work.find_by(day: Date.today).start_time
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
      current_user.works.where(day: Time.new(y,m).all_month).select("end_time").count * 7.50
    end
    
    def aaaa(m)
      if m == 12
        m - 11
      else
        m + 1
      end
    end  
    
    def bbbb(m)
      if m == 1
         m + 11
      else
         m - 1
      end
    end
    
    
    
    
    
end
