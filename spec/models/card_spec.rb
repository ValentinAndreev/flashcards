require "rails_helper"
require 'support/factory_girl'

RSpec.describe Card, type: :model do
  
context 'check translation' do
  let!(:card) { create(:card) } 
  
  it "right translation" do
    result = translation({ id: 1, text: 'not' }) 
    expect(result) == "right translation"
  end
  
  it "change date" do
    result = translation({ id: 1, text: 'not' })   
    expect(card.review_date) == 3.days.from_now.to_date    
  end
  
  it "wrong translation" do
    result = translation({ id: 1, text: 'yes' })
    expect(result) == card.translated_text
  end
  
  def translation(params)
    Card.check_translation(params) 
  end  
end

context 'validations' do  
  it "compare validation" do
    card = build(:card, original_text: 'not')
    expect(card.compare[0]) == "Equal text"
  end
  
  it "set date" do
    card = create(:card, review_date: nil)
    expect(card.set_date) == Date.today
  end
end  
end