require "rails_helper"
require 'support/factory_girl'

RSpec.describe Card, type: :model do
  
context 'validations' do  
  it "compare validation" do
    card = build(:card, original_text: 'not')
    expect(card.compare[0]).to eq("Equal text")
  end
  
  it "set date" do
    card = create(:card, review_date: nil)
    expect(card.review_date.strftime('%F %H').to_datetime).to eq(Time.now.strftime('%F %H').to_datetime)
  end
  
  it 'not have a pack' do
    card = build(:card, pack_id: nil)
    expect(card.valid?).to eq(false)
    expect(card.errors[:pack][0]).to eq("can't be blank")
  end

  it 'random card' do
    pack = create(:pack)
    card = create(:card, pack: pack, review_date: Time.now + 10.hours)
    card1 = create(:card, pack: pack, review_date: Time.now)  
    expect(Card.randomcard).to eq(card1)      
  end
end  
end