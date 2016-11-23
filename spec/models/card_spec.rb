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
    expect(card.set_date).to eq(Date.today)
  end
  
  it 'not have a user' do
    card = build(:card, user_id: nil)
    expect(card.valid?).to eq(false)
    expect(card.errors[:user][0]).to eq("can't be blank")
  end
end  
end