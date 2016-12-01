require 'rails_helper'
require 'support/factory_girl'

def t(string, options={})
  I18n.t(string, options)
end

feature 'Guests actions' do
  before do
    visit root_path    
  end
  
  scenario 'guest must see invitation to register or login' do
    expect(page).to have_content t('Hello_you_must_register_or_login_to_continue')     
  end 
  
  scenario 'guest can`t edit another users profile' do
    expect(page).to_not have_content t('Edit_profile')    
  end 
  
  scenario 'guest can`t see cards' do
    click_on t('All_cards')   
    expect(page).to_not have_content t('Show')  
  end   
  
  scenario 'guest can`t check another users cards' do
    click_on t('Training')      
    expect(page).to_not have_content t('Word')  
  end    
  
  scenario 'guest can`t create card' do  
    click_on t('New_card')    
    expect(page).to_not have_content t('New')       
  end 
end
