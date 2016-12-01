require 'rails_helper'
require 'support/factory_girl'

def t(string, options={})
  I18n.t(string, options)
end

feature 'User can`t do this' do
  before do
    @user = create(:user) 
    visit root_path
    click_on t('Login')
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: 'password'
    click_on t('Log')
    expect(page).to have_content t('Succesfully_logined')
    @card = create(:card, user: @user) 
    @user1 = create(:user, email: 'mail1@mail.com', password: 'password1', password_confirmation: 'password1')
    @card1 = create(:card, original_text: 'ja', translated_text: 'yes', user: @user1)         
  end
  
  scenario 'user can`t edit another users profile' do
    click_on t('Edit_profile')            
    expect(page).to_not have_content @user1.email                 
  end 
  
  scenario 'user can`t see another users cards' do
    click_on t('All_cards')
    expect(page).to_not have_content @card1.original_text          
  end   
  
  scenario 'user can`t check another users cards' do
    click_on t('Training')   
    expect(page).to_not have_content @card1.original_text      
  end   
end
