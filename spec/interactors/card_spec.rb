require "rails_helper"
require 'support/factory_girl'
require "check_translation.rb"

RSpec.describe Card, type: :model do
  
  context 'check translation' do
  let!(:card) { create(:card) } 
  
    it "right translation" do
      cheks = 0
      while cheks < 5
        expect(card.right_checks).to eq(cheks)         
        result = translation({ text: 'not' }) 
        expect(result).to be_a_success
        cheks +=1
      end
      result = translation({ text: 'not' }) 
      expect(card.right_checks).to eq(5) 
    end
  
    it "change date" do
      result = translation({ text: 'not' })   
      expect(card.review_date).to eq(12.hours.from_now.to_date)    
    end
  
    it "wrong translation" do
      cheks = 0
      while cheks < 2
        expect(card.wrong_checks).to eq(cheks)         
        result = translation({ text: 'yes' })
        expect(result).not_to be_a_success
        cheks +=1
      end 
      result = translation({ text: 'yes' })
      expect(card.wrong_checks).to eq(0)        
      expect(card.right_checks).to eq(1)       
    end
  
    def translation(params)
      CheckTranslation.call(card: card, params: params)
    end
  end
end