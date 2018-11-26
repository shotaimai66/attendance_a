require 'rails_helper'

RSpec.describe Work, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  
  before do
    @user = FactoryBot.create(:user)
    @another = FactoryBot.create(:another)
  end
  
  #外部キーがあれば有効
  it "is valid work" do
    work = @user.works.build()
    expect(work).to be_valid
  end
  
  #外部キーがなければ無効
  it "is valid work" do
    work = Work.new()
    expect(work).to be_invalid
  end
  
end
