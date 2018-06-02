module StaticPagesHelper


    def work_name
        if Work.find_by_id(1).nil?
          @name = "出社"
        elsif Work.find_by_id(1).end_time
          @name = "----"
        elsif Work.find_by_id(1).start_time
          @name = "退社"
        else
          @name = "出社"
        end
    end
    
    def start_time
        Work.find_by_id(1) && Work.find_by_id(1).start_time
    end
    
    
    def end_time
      Work.find_by_id(1) && Work.find_by_id(1).end_time
    end
    
   
    
end
