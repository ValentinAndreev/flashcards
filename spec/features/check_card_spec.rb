require 'rails_helper'
require 'support/factory_girl'

feature 'Check translation' do  
  before do
    user = create(:user) 
    visit root_path
    click_on 'Вход'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_on 'Войти'
    expect(page).to have_content 'Вход' 
    card = create(:card, user: user)     
    click_on 'Проверка'        
  end
   
  scenario 'right translation' do    
    expect(page).to have_content 'nicht'
    save_and_open_page
    fill_in :Translated_text, with: 'not'     
    click_on :Send  
    expect(page).to have_content 'Правильно.'  
  end

  scenario 'wrong translation' do  
    expect(page).to have_content 'nicht'    
    fill_in :Translated_text, with: 'yes'     
    click_on :Send  
    expect(page).to have_content 'Не правильно.' 
  end
end