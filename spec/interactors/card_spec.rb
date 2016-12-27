require "rails_helper"
require 'support/factory_girl'
require "check_translation.rb"

RSpec.describe Card, type: :model do

  def translation(params)
      CheckTranslation.call(card: card, params: params)
  end

  context 'check translation' do
    let!(:card) { create(:card) } 
  
    it "first translation +24" do
      result = translation({ text: 'abstractiveness' }) 
      expect(result).to be_a_success
      expect(card.checks).to eq(1)    
      expect(card.review_date.strftime('%F %H:%M')).to eq((Time.zone.now. + 24.hours).strftime('%F %H:%M'))  
      expect(card.review_time).to eq(24)
      expect(card.ef).to eq(2.5)      
    end

    it "second translation +144" do
      card.checks = 1
      result = translation({ text: 'abstractiveness' }) 
      expect(result).to be_a_success
      expect(card.checks).to eq(2)    
      expect(card.review_date.strftime('%F %H:%M')).to eq((Time.zone.now. + 144.hours).strftime('%F %H:%M'))   
      expect(card.review_time).to eq(144)
      expect(card.ef).to eq(2.5)       
    end
    
    it 'ef must be greater that 1.3' do 
      10.times {
        datejump = Card.find(card.id).review_date
        Timecop.travel(datejump)        
        result = translation({ text: 'abstractiveness' })
        expect(card.ef).to be >= 1.3
        Timecop.return   
      }
    end
  end    
  
  context "set new time in all cases" do
    let!(:card) { create(:card) }     
    before do
      2.times {
        datejump = Card.find(card.id).review_date
        Timecop.travel(datejump)        
        result = translation({ text: 'abstractiveness' })
        Timecop.return   
      }           
    end

    it "right answer set time for perfect response (after first two checks)" do   
      result = translation({ text: 'abstractiveness' }) 
      expect(card.ef).to eq(2.6)
      expect(card.review_time).to eq(375)
    end

    it "right answer set time for correct response after a hesitation & do not change review date if q == 4" do
      result = translation({ text: 'abstractivenes' }) 
      expect(card.ef).to eq(1)
      expect(card.review_time).to eq(0)
      result = translation({ text: 'abstractivenes' }) 
      expect(card.ef).to eq(1)
      expect(card.review_time).to eq(0)      
    end    

    it "right answer set time for correct response recalled with serious difficulty (after first two checks)" do     
      result = translation({ text: 'abstractivene' }) 
      expect(card.review_time).to eq(340)            
    end

    it "wrong answer set time for incorrect response; where the correct one seemed easy to recall (after first two checks)" do      
      result = translation({ text: 'abstractiven' })       
      expect(card.review_time).to eq(24)  
      expect(card.ef).to eq(2.5)   
    end

    it "wrong answer set time for incorrect response; the correct one remembered (after first two checks)" do      
      result = translation({ text: 'abstractive' })    
      expect(card.review_time).to eq(24)  
      expect(card.ef).to eq(2.5)           
    end

    it "wrong answer set time for complete blackout (after first two checks)" do   
      result = translation({ text: 'abstractiv' })  
      expect(card.review_time).to eq(24)   
      expect(card.ef).to eq(2.5)                  
    end
  end
end