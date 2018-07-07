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
        if @name == "出社"#出社ボタンが表示されている時
            if Work.find_by(user_id: select_user.id, day: Date.today)
            #(update)出社ボタン押下の日付のレコードが存在したら、それを更新
            #秒以下を切り捨てるように更新設定
                Work.find_by(user_id: select_user.id, day: Date.today ).update(start_time: Time.new(Time.now.year,Time.now.month,Time.now.day,Time.new.hour,Time.now.min,00))
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
        works_params.each do |id, item|
            work = select_user.works.find(id)
                #未来の情報は一般ユーザーは更新できないように設定（管理者のみ編集可能）
                if work.day > Date.today && !current_user.admin?
                #出社時間と退社時間の両方の存在を検証
                elsif !work.start_time&&work.end_time
                    flash[:warning] = '出社時間と退社時間は両方入力してください。'
                else
                    work.update_attributes(item)
                    flash[:success] = "更新しました！なお本日以降の更新はできません。"
                end
        end
    #セレクトユーザーの編集した月ページへ
    redirect_to  user_work_path(select_user,params[:piyo])
    end
    
    
     private
    def works_params
      params.permit(works: [:start_time, :end_time, :note])[:works]
    end

    
    
  
    

   
   
    
end
