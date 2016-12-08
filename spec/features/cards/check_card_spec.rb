require 'rails_helper'
require 'support/factory_girl'

def t(string, options={})
  I18n.t(string, options)
end

feature 'Check translation' do  
  before do
    user = create(:user) 
    visit welcome_path     
    click_on t('Login')
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_on t('Log')    
    expect(page).to have_content user.email
    pack = create(:pack, user: user)    
    card = create(:card, pack: pack, user_id: user.id)       
    visit showcard_path      
  end
   
  scenario 'right translation' do 
    expect(page).to have_content 'nicht'
    fill_in t('Translated_text'), with: 'not'
    click_on t('Send')
    expect(page).to have_content t('You_are_right')
  end

  scenario 'wrong translation' do  
    expect(page).to have_content 'nicht'    
    fill_in t('Translated_text'), with: 'yes'
    click_on t('Send')
    expect(page).to have_content t('You_are_wrong_right_translation_is')
  end
end