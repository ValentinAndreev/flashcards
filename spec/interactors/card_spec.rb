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
      result = translation({ text: 'not' }) 
      expect(result).to be_a_success
      expect(card.checks).to eq(1)    
      expect(card.review_date.strftime('%F %H:%M')).to eq((Time.zone.now. + 24.hours).strftime('%F %H:%M'))  
      expect(card.review_time).to eq(24)
      expect(card.ef).to eq(2.5)      
    end

    it "second translation +144" do
      card.checks = 1
      result = translation({ text: 'not' }) 
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
        result = translation({ text: 'not' })
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
        result = translation({ text: 'not' })
        Timecop.return   
      }           
    end

    it "right answer set time for perfect response (after first two checks)" do   
      result = translation({ text: 'not', time: '1' }) 
      expect(card.ef).to eq(2.6)
      expect(card.review_time).to eq(375)
    end

    it "right answer set time for correct response after a hesitation (after first two checks)" do
      result = translation({ text: 'not', time: '5' })  
      expect(card.ef).to eq(2.5)
      expect(card.review_time).to eq(360)
    end

    it "right answer set time for correct response recalled with serious difficulty (after first two checks)" do     
      result = translation({ text: 'not', time: '10' }) 
      expect(card.review_time).to eq(340)            
    end

    it "wrong answer set time for incorrect response; where the correct one seemed easy to recall (after first two checks)" do      
      result = translation({ text: 'no' })       
      expect(card.review_time).to eq(314)        
    end

    it "wrong answer set time for incorrect response; the correct one remembered (after first two checks)" do      
      result = translation({ text: 'nottt' })    
      expect(card.review_time).to eq(283)          
    end

    it "wrong answer set time for complete blackout (after first two checks)" do   
      result = translation({ text: 'notttt' })  
      expect(card.review_time).to eq(245)            
    end
  end
end