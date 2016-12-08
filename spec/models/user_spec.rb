require "rails_helper"
require 'support/factory_girl'

RSpec.describe User, type: :model do
  
context 'packs' do  
  before do
  	@user = create(:user)
    @pack = create(:pack, user: @user, base: false)  	
  end

  it "find review pack" do
    @user.set_default(@pack)  	
    expect(@user.review_pack).to eq(@pack)
  end
  
  it "set default pack" do
    @user.set_default(@pack)
    expect(@pack.base).to eq(true)
  end
  
  it 'remove default pack' do
    @user.set_default(@pack)
    @user.remove_default
    expect(@pack.base).to eq(false)
  end
end  

context 'cards' do  
  before do
  	@user = create(:user)
    @pack = create(:pack, user: @user, base: true)  	
    @card = create(:card, pack: @pack, user_id: @user.id)      
  end

  it "get card" do
    expect(@user.get_card(@pack.id)).to eq(@card)
  end

  it "random card from all" do
    expect(@user.random_all).to eq(@card)
  end

  it "select card - choosen" do
    pack1 = create(:pack, user: @user, base: true)  
    card1 = create(:card, pack: pack1)   	
    expect(@user.select_card(@pack.id)[0]).to eq(@card)    
  end  

   it "select card - base" do
    pack1 = create(:pack, user: @user, base: true)  
    card1 = create(:card, pack: pack1)          	
    @user.set_default(@pack)   	
    expect(@user.select_card[0]).to eq(@card)
  end  

   it "select card - random" do
    expect(@user.select_card[0]).to eq(@card)
  end  
end  
end