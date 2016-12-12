require "rails_helper"
require 'support/factory_girl'
require "check_translation.rb"

RSpec.describe Card, type: :model do
  
  context 'check translation' do
  let!(:card) { create(:card) } 
  
    it "right translation" do
      result = translation({ text: 'not' }) 
      expect(result).to be_a_success
      expect(card.right_checks).to eq(1)      
    end
  
    it "change date" do
      result = translation({ text: 'not' })   
      expect(card.review_date).to eq(12.hours.from_now.to_date)    
    end
  
    it "wrong translation" do
      result = translation({ text: 'yes' })
      expect(result).not_to be_a_success
      expect(card.wrong_checks).to eq(1)  
    end

    it 'wrong translation reduce time after 3 mistakes' do 
      card.wrong_checks = 2
      result = translation({ text: 'yes' })  
      expect(card.wrong_checks).to eq(0)
      expect(card.right_checks).to eq(1)   
    end
  
    def translation(params)
      CheckTranslation.call(card: card, params: params)
    end
  end
end