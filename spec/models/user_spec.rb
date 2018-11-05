require 'rails_helper'



RSpec.describe User, type: :model do
    # before(:all) do
    #   @user = FactoryBot.create(:user)
    #   @nil_name_user = FactoryBot.create(:nil_name_user)
    # end
    
  it "is valid  user" do
    user = User.new(name: "syouta", email: "syouta@gmial.com", password: "0000000")
    expect(user).to be_valid
  end
  it "is invalid user" do
    user = User.new
    expect(user).to be_invalid
  end
  it "is invalid password be < 6" do
    user = User.new(name: "syouta", email: "syouta@gmial.com", password: "00000")
    user.valid?
    expect(user.errors[:password]).to include("は6文字以上で入力してください")
  end
  
  # it "is invalid user" do
  #     user = User.new
  #     expect(user).to be_invalid
  # end
  # it "is invalid without title" do
  #   user = User.new(name: nil)
  #   user.valid?
  #   expect(user.errors[:name]).to include("を入力してください")
  # end
  
end
