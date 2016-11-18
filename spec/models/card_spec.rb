require "rails_helper"

RSpec.describe Card, type: :model do
  it "right translation" do
    card = Card.create(original_text: 'nicht', translated_text: 'not', review_date: Date.today, id: 1)
    params = { :id => card.id, :text => 'not' }  
    translation = card.check_translation(params)    
    expect(translation).to be false
    expect(card.review_date).to eq 3.days.from_now.to_date      
  end
  
  it "wrong translation" do
    card = Card.create(original_text: 'nicht', translated_text: 'not', review_date: Date.today, id: 1)
    params = { :id => card.id, :text => 'yes' }  
    translation = card.check_translation(params)
    expect(translation).to eq card.translated_text
  end
  
  it "compare validation" do
    card = Card.create(original_text: 'not', translated_text: 'not', review_date: Date.today, id: 1)
    expect(card.compare).not_to be nil
  end
  
  it "set date" do
    card = Card.create(original_text: 'not', translated_text: 'not', review_date: nil, id: 1)
    expect(card.set_date).to eq Date.today
  end
end