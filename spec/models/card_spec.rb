require "rails_helper"

RSpec.describe Card, type: :model do
  it "right translation" do
    card = Card.create(original_text: 'nicht', translated_text: 'not', review_date: Date.today, id: 1)
    params = { :id => 1, :text => 'not' }  
    translation = Card.check_translation(params)    
    expect(translation).to be false
  end
  
  it "change date" do
    card = Card.create(original_text: 'nicht', translated_text: 'not', review_date: Date.today, id: 1)
    params = { :id => 1, :text => 'not' }  
    translation = Card.check_translation(params)    
    expect(card.review_date).to eq 3.days.from_now.to_date      
  end
  
  it "wrong translation" do
    card = Card.create(original_text: 'nicht', translated_text: 'not', review_date: Date.today, id: 1)
    params = { :id => 1, :text => 'yes' }  
    translation = Card.check_translation(params)
    expect(translation).to eq card.translated_text
  end
  
  it "compare validation" do
    card = Card.create(original_text: 'not', translated_text: 'not', review_date: Date.today, id: 1)
    expect(card.compare[0]).to eq "Equal text"
  end
  
  it "set date" do
    card = Card.create(original_text: 'not', translated_text: 'not', review_date: nil, id: 1)
    expect(card.set_date).to eq Date.today
  end
end