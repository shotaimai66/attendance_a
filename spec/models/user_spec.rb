require 'rails_helper'



RSpec.describe User, type: :model do
    # before(:all) do
    #   @user = FactoryBot.create(:user)
    #   @nil_name_user = FactoryBot.create(:nil_name_user)
    # end
    
    before do
      @user = FactoryBot.create(:user)
    end
  #Factory.botが有効かどうか検証 
  it "is valid  user" do
    # user = User.new(name: "syouta", email: "syouta@gmial.com", password: "0000000")
    expect(@user).to be_valid
  end
  
  #名前、email、パスワードがあれば有効かどうか検証 
  it "is valid  user" do
    user = User.new(name: "syouta", email: "syouta@gmial.com", password: "0000000")
    expect(user).to be_valid
  end
  
  # ユーザーの名前がなければ無効
  it "is invalid user" do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include('を入力してください')
  end
  
  # ユーザーのメールアドレスがなければ無効
  it "is invalid user" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include('を入力してください')
  end
  
  # ユーザーのpasswordがなければ無効
  it "is invalid user" do
    user = User.new(password: nil)
    user.valid?
    expect(user.errors[:email]).to include('を入力してください')
  end
  
  it "is invalid password be < 6" do
    user = User.new(name: "syouta", email: "syouta@gmial.com", password: "00000")
    user.valid?
    expect(user.errors[:password]).to include("は6文字以上で入力してください")
  end
  
  
  
end
