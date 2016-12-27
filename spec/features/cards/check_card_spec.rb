require 'rails_helper'
require 'support/factory_girl'

def t(string, options={})
  I18n.t(string, options)
end

feature 'Check translation' do  
  let!(:user) { create(:user) } 
  let!(:pack) { create(:pack, user: user, base: false) }   
  let!(:card) { create(:card, pack: pack, user_id: user.id) } 

  before do
    visit welcome_path     
    click_on t('Sign_in')
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_on t('Log')    
    expect(page).to have_content user.email     
    visit showcard_path      
  end
   
  scenario 'right translation' do 
    expect(page).to have_content 'abstraktheit'
    fill_in t('Translated_text'), with: 'abstractiveness'
    click_on t('Send')
    expect(page).to have_content t('This_pack_have_no_cards_with_review_date')
  end

  scenario 'wrong translation' do  
    expect(page).to have_content 'abstraktheit'    
    fill_in t('Translated_text'), with: 'competitiveness'
    click_on t('Send')
    expect(page).to have_content t('You_are_wrong_right_translation_is')
  end

  scenario 'sequence of translations with jumps' do 
    5.times {
      datejump = Card.find(card.id).review_date
      Timecop.travel(datejump)
      visit showcard_path   
      expect(page).to have_content 'abstraktheit'
      fill_in t('Translated_text'), with: 'abstractiveness'
      click_on t('Send')  
      expect(page).to have_content t('This_pack_have_no_cards_with_review_date')      
      Timecop.return   
    }
  end
end 