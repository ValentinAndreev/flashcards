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

    it "max right translation" do
      card.right_checks = 5      
      result = translation({ text: 'not' }) 
      expect(result).to be_a_success
      expect(card.right_checks).to eq(5)       
    end

    it "right translation change of date" do
      card.right_checks = 0      
      time = [12, 72, 168, 336, 672]
      i = 0
      5.times { 
        review = card.review_date
        result = translation({ text: 'not' }) 
        expect(card.review_date).to eq(review + time[i].hours)  
        i += 1 
      }       
    end
  
    it "wrong translation" do
      card.right_checks = 1
      result = translation({ text: 'yes' }) 
      expect(result).not_to be_a_success
      expect(card.wrong_checks).to eq(1)  
    end

    it "wrong translation reduce number of right cheks and change date back" do
      card.right_checks = 5
      card.review_date = Time.now + 672.hours
      time = [0, 12, 72, 168, 336]
      i = 4
      4.times { 
        review = card.review_date
        3.times { result = translation({ text: 'yes' })  }
        expect(card.review_date).to eq(review - time[i].hours)  
        expect(card.right_checks).to eq(i)          
        i -= 1 
      }                     
    end

    it "wrong translation do not countig if we have 0 right cheks" do
      card.right_checks = 0
      3.times { result = translation({ text: 'yes' }) 
      expect(result).not_to be_a_success }
      expect(card.right_checks).to eq(0)   
      expect(card.wrong_checks).to eq(0)         
    end
  
    def translation(params)
      CheckTranslation.call(card: card, params: params)
    end
  end
end