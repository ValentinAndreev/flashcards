require "rails_helper"
require 'support/factory_girl'

RSpec.describe User, type: :model do
  
context 'packs' do  
  let!(:user) { create(:user) } 
  let!(:pack) { create(:pack, user: user, base: false) }   

  it "find review pack" do
    user.default(pack)  	
    expect(user.review_pack).to eq(pack)
  end
  
  it "set default pack" do
    user.default(pack)
    expect(pack.base).to eq(true)
  end
  
  it 'remove default pack' do  	
    user.default(pack)
    user.remove_default
    expect(user.packs.first.base).to eq(false)
  end
end  

context 'cards' do  
  let!(:user) { create(:user) } 
  let!(:pack) { create(:pack, user: user, base: false) }   
  let!(:card) { create(:card, pack: pack, user_id: user.id) }    

  it 'default_cards' do
    user.default(pack)
    expect(user.select_card[0]).to eq(card)
  end

  it "select card - base" do
    pack1 = create(:pack, user: user, base: true)  
    card1 = create(:card, pack: pack1)          	
    user.default(pack)   	
    expect(user.select_card[0]).to eq(card)
  end  

   it "select card - random" do
    expect(user.select_card[0]).to eq(card)
  end  
end  

context 'locale' do

  it 'cant create locale not included in available_locales' do
    user = build(:user, locale: :qqqqq)
    expect(user.valid?).to eq(false)
    expect(user.errors[:locale][0]).to eq("is not included in the list")
  end

  it 'can create locale included in available_locales' do
    locale = I18n.available_locales[0]
    user = build(:user, locale: locale)
    expect(user.valid?).to eq(true)
  end
end
end