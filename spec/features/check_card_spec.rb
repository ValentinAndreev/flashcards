require 'rails_helper'
require 'support/factory_girl'

feature 'Check translation' do
  let!(:card) { create(:card) } 
   
  scenario 'right translation' do 
    visit root_path   
    expect(page).to have_content 'nicht'
    fill_in 'Перевод', with: 'not'     
    click_on 'Отправить'  
    expect(page).to have_content 'Правильно.'  
  end

  scenario 'wrong translation' do   
    visit root_path  
    expect(page).to have_content 'nicht'    
    fill_in 'Перевод', with: 'yes'
    click_on 'Отправить'    
    expect(page).to have_content 'Не правильно.' 
  end
end