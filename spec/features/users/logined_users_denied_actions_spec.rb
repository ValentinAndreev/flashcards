require 'rails_helper'
require 'support/factory_girl'

def t(string, options={})
  I18n.t(string, options)
end

feature 'User can`t do this' do
  before do
    @user = create(:user) 
    visit root_path
    click_on t('Sign_in')
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: 'password'
    click_on t('Log')
    expect(page).to have_content @user.email
    @pack = create(:pack, user: @user)    
    @card = create(:card, pack: @pack) 
    @user1 = create(:user, email: 'mail1@mail.com', password: 'password1', password_confirmation: 'password1')
    @pack1 = create(:pack, user: @user1, title: 'AnotherPack')  
    @card1 = create(:card, original_text: 'ja', translated_text: 'yes', pack: @pack)         
  end
  
  scenario 'user can`t edit another users profile' do
    click_on t('Edit_profile')            
    expect(page).to_not have_content @user1.email                 
  end 
  
  scenario 'user can`t see another users packs' do
    click_on t('All_packs')
    expect(page).to_not have_content @pack1.title          
  end     
end
