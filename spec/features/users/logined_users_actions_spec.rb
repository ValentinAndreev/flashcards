require 'rails_helper'
require 'support/factory_girl'

def t(string, options={})
  I18n.t(string, options)
end

feature 'Logined user actions' do    
  before do
    @user = create(:user) 
    visit root_path
    click_on t('Login')
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: 'password'
    click_on t('Log')
    expect(page).to have_content t('Succesfully_logined')
    @card = create(:card, user: @user)        
  end
  
  scenario 'users logout' do
    click_on t('Logout')
    expect(page).to have_content t('Logout')      
  end   
  
  scenario 'user can edit own profile' do  
    click_on t('Edit_profile') 
    fill_in 'Email', with: 'mail1@mail.com'
    fill_in 'Password', with: 'password1'   
    fill_in 'Password confirmation', with: 'password1'        
    click_on 'Update User'     
    expect(page).to have_content t('Profile_was_changed')
  end
  
  scenario 'user can create card' do   
    expect(@card.user).to eq (@user)      
  end 
    
  scenario 'user can edit own cards' do
    @card.translated_text = 'yes'
    @card.save
    click_on t('All_cards')  
    click_on t('Show')     
    click_on t('Edit') 
    fill_in 'Translated text', with: 'not'
    click_on 'Update Card'   
    expect(page).to have_content('not')     
  end 

  scenario 'user can delete own cards' do
    click_on t('All_cards')  
    click_on t('Show')     
    click_on t('Delete')  
    expect(page).to_not have_content('not')    
  end 
  
  scenario 'user can check own cards' do
    click_on t('Training')      
    expect(page).to have_content t('Word')      
  end      

  scenario 'test of attached image' do     
    expect(@card.image_file_name).to eq ('cat.jpg')
  end     
end  
