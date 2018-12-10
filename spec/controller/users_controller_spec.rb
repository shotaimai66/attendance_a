require 'rails_helper'


RSpec.describe UsersController, type: :controller do
    
    def log_in(user)
        session[:user_id] = user.id
    end
    

    
    
    before(:each) do
        @admin_user = create(:admin_user)
        @normal_user = create(:normal_user)
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
        # # redirectされるか？
        # it "responds successfully@normal_user@normal_user@normal_user" do
        #     log_in @normal_user
        #     expect(subject).to receive(:admin_user).and_call_original
        #     get :index
        #     expect(response).to redirect_to "/"
        # end
        # # ２００レスポンスが帰ってきているか？
        # it "returns a 200 response" do
        #     log_in @normal_user
        #     get :index
        #     expect(response).to have_http_status "200"
        # end
      end
    end
    
    describe "#new" do
        it "ログインしてshowページに遷移" do
            get :new
            expect(response).to have_http_status "200"
        end
    end
    
    describe "#create" do
        it "ユーザー登録でworks#showにリダイレクト" do
            post :create, params: {user: {name: "加藤純一",
                                   email: "changemymind65@gmial.com",
                                   password: "111111",
                                   admin: false,
            } }
            expect(response).to redirect_to user_work_path(3,Date.today)
            
        end
        
        it "不正ユーザー登録でuser#newにrender" do
            post :create, params: {user: {name: "加藤純一",
                                   email: "changemymind6@gmial.com",
                                   password: "111111",
                                   admin: false,
            } }
            expect(response).to render_template "new"
        end
    end
        
    describe "#edit" do
        context "login_user" do
            # レスポンス２００？
            it "return response 200" do
                log_in(@normal_user)
                get :edit, params: {id: @normal_user.id}
                expect(response).to have_http_status '200'
            end
        end
        
        context "not_correct_user" do
            # root画面にリダイレクトしてる？
            it "redirect_to root" do
                log_in(@normal_user)
                get :edit, params: {id: 1}
                expect(response).to redirect_to root_url
            end
        end
        
        context "not_login_user" do
            # ログイン画面にリダイレクトしてる？
            it "redirect_to log_in?" do
                get :edit, params: {id: 2}
                expect(flash[:danger]).to match 'ログインしてください。'
                expect(response).to redirect_to login_url
            end
        end
    end
    
    describe '#update' do
        context 'login_user' do
            it 'redirect_to works#show after update user'
            end
        end
        
        context 'not_login_user' do
        end
        
        context 'not_correct_user' do
        end
    end
    
end