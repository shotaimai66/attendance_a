require 'rails_helper'


RSpec.describe UsersController, type: :controller do
    
    def log_in(user)
        session[:user_id] = user.id
    end
    
    before do
        @admin_user = User.create(name: "加藤純一",
                            email: "changemymind6@gmial.com",
                            password: "111111",
                            admin: true,
                            )
        @normal_user = User.create(name: "加藤純一",
                            email: "changemymind6@gmial.com",
                            password: "111111",
                            admin: false,
                            )
    end
    
    describe "#index" do
      context "when admin_user" do
        # 正常なレスポンスか？
        it "responds successfully" do
            log_in @admin_user
            get :index
            expect(response).to be_success
        end
        # ２００レスポンスが帰ってきているか？
        it "returns a 200 response" do
            log_in @admin_user
            get :index
            expect(response).to have_http_status "200"
        end
      end
      
      context "when normal_user" do
        # redirectされるか？
        # it "responds successfully@normal_user@normal_user@normal_user" do
        #     log_in @normal_user
        #     get :index
        #     expect(response).to redirect_to root_url
        # end
        # # ２００レスポンスが帰ってきているか？
        # it "returns a 200 response" do
        #     log_in @normal_user
        #     get :index
        #     expect(response).to have_http_status "200"
        # end
      end
      
    end

end