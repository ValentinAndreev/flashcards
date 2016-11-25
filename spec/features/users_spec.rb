require 'rails_helper'
require 'support/factory_girl'

feature 'Users login and creation' do
  scenario 'create user' do
    visit root_path    
    click_on I18n.t(:Registration)    
    fill_in 'Email', with: 'mail@mail.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'     
    click_on I18n.t(:Create_user)    
    expect(page).to have_content I18n.t(:Succesfully_registered_and_entered)       
  end 
  
  scenario 'users login' do
    user = create(:user) 
    visit root_path
    click_on I18n.t(:Login)
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'   
    click_on I18n.t(:Log)
    expect(page).to have_content I18n.t(:Succesfully_logined)
  end  
end

feature 'Logined user actions' do    
  before do
    user = create(:user) 
    visit root_path
    click_on I18n.t(:Login)
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_on I18n.t(:Log)
    expect(page).to have_content I18n.t(:Succesfully_logined)
    card = create(:card, user: user)        
  end
  
  scenario 'users logout' do
    click_on I18n.t(:Logout)
    expect(page).to have_content 'Выход'       
  end   
  
  scenario 'user can edit own profile' do  
    click_on I18n.t(:Edit_profile) 
    fill_in 'Email', with: 'mail1@mail.com'
    fill_in 'Password', with: 'password1'   
    fill_in 'Password confirmation', with: 'password1'        
    click_on 'Update User'     
    expect(page).to have_content I18n.t(:Profile_was_changed)
  end
  
  scenario 'user can see own cards' do   
    click_on I18n.t(:All_cards)      
    expect(page).to have_content I18n.t(:Show)
  end   
  
  scenario 'user can create card' do
    click_on I18n.t(:New_card)      
    expect(page).to have_content I18n.t(:New)      
  end 
    
  scenario 'user can edit own cards' do
    click_on I18n.t(:All_cards) 
    click_on I18n.t(:Show)     
    expect(page).to have_content I18n.t(:Delete)  
  end 
  
  scenario 'user can check own cards' do
    click_on I18n.t(:Training)     
    expect(page).to have_content I18n.t(:Word)   
  end        
end  

feature 'User can`t do this' do
  before do
    @user = create(:user) 
    visit root_path
    click_on I18n.t(:Login)
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: 'password'
    click_on I18n.t(:Log)
    expect(page).to have_content I18n.t(:Succesfully_logined)
    @card = create(:card, user: @user) 
    @user1 = create(:user, email: 'mail1@mail.com', password: 'password1', password_confirmation: 'password1')
    @card1 = create(:card, original_text: 'ja', translated_text: 'yes', user: @user1)         
  end
  
  scenario 'user can`t edit another users profile' do
    click_on I18n.t(:Edit_profile)            
    expect(page).to_not have_content @user1.email                 
  end 
  
  scenario 'user can`t see another users cards' do
    click_on I18n.t(:All_cards)
    expect(page).to_not have_content @card1.original_text          
  end   
  
  scenario 'user can`t check another users cards' do
    click_on I18n.t(:Training)   
    expect(page).to_not have_content @card1.original_text      
  end   
end

feature 'Guests actions' do
  before do
    visit root_path    
  end
  
  scenario 'guest must see invitation to register or login' do
    expect(page).to have_content I18n.t(:Hello_you_must_register_or_login_to_continue)     
  end 
  
  scenario 'guest can`t edit another users profile' do
    expect(page).to_not have_content I18n.t(:Edit_profile)    
  end 
  
  scenario 'guest can`t see cards' do
    click_on I18n.t(:All_cards)   
    expect(page).to_not have_content I18n.t(:Show)  
  end   
  
  scenario 'guest can`t check another users cards' do
    click_on I18n.t(:Training)      
    expect(page).to_not have_content I18n.t(:Word)  
  end    
  
  scenario 'guest can`t create card' do  
    click_on I18n.t(:New_card)    
    expect(page).to_not have_content I18n.t(:New)       
  end 
end



