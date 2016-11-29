require 'rails_helper'
require 'support/factory_girl'

def t(string, options={})
  I18n.t(string, options)
end

feature 'Users login and creation' do
  scenario 'create user' do
    visit root_path    
    click_on t('Registration')    
    fill_in 'Email', with: 'mail@mail.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'     
    click_on t('Create_user')    
    expect(page).to have_content t('Succesfully_registered_and_entered')       
  end 
  
  scenario 'users login' do
    user = create(:user) 
    visit root_path
    click_on t('Login')
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'   
    click_on t('Log')
    expect(page).to have_content t('Succesfully_logined')
  end  
end

feature 'Logined user actions' do    
  before do
    user = create(:user) 
    visit root_path
    click_on t('Login')
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_on t('Log')
    expect(page).to have_content t('Succesfully_logined')
    card = create(:card, user: user)        
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
  
  scenario 'user can see own cards' do   
    click_on t('All_cards')      
    expect(page).to have_content t('Show')
  end   
  
  scenario 'user can create card' do
    click_on t('New_card')      
    expect(page).to have_content t('New')      
  end 
    
  scenario 'user can edit own cards' do
    click_on t('All_cards') 
    click_on t('Show')     
    expect(page).to have_content t('Delete')  
  end 
  
  scenario 'user can check own cards' do
    click_on t('Training')     
    expect(page).to have_content t('Word')   
  end  

  scenario 'user can attach image to card' do    
    click_on t('New_card') 
    attach_file 'card[image]', Rails.root.to_s + '/spec/cat.jpg'
    save_and_open_page
    expect(page).to have_content 'cat.jpg'  
  end       
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



