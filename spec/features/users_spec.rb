require 'rails_helper'
require 'support/factory_girl'

feature 'Users login and creation' do
  scenario 'create user' do
    visit root_path    
    click_on 'Регистрация'     
    fill_in 'Email', with: 'mail@mail.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'   
    click_on 'Create User' 
    expect(page).to have_content 'Успешная регистрация и вход'        
  end 
  
  scenario 'users login' do
    user = create(:user) 
    visit root_path
    click_on 'Вход'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_on 'Войти'
    expect(page).to have_content 'Вход'     
  end  
end

feature 'Logined user actions' do    
  before do
    user = create(:user) 
    visit root_path
    click_on 'Вход'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_on 'Войти'
    expect(page).to have_content 'Вход' 
    card = create(:card, user: user)        
  end
  
  scenario 'users logout' do
    click_on 'Выход'
    expect(page).to have_content 'Выход'       
  end   
  
  scenario 'user can edit own profile' do  
    click_on 'Редактировать профиль'  
    fill_in 'Email', with: 'mail1@mail.com'
    fill_in 'Password', with: 'password1'   
    fill_in 'Password confirmation', with: 'password1'        
    click_on 'Update User'     
    expect(page).to have_content 'Вы изменили свой профиль'  
  end
  
  scenario 'user can see own cards' do   
    click_on 'Все карточки'       
    expect(page).to have_content 'Показать'      
  end   
  
  scenario 'user can create card' do
    click_on 'Новая карточка'      
    expect(page).to have_content 'Создать'        
  end 
    
  scenario 'user can edit own cards' do
    click_on 'Все карточки' 
    click_on 'Показать'     
    expect(page).to have_content 'Удалить'   
  end 
  
  scenario 'user can check own cards' do
    click_on 'Проверка'     
    expect(page).to have_content 'Слово'    
  end        
end  

feature 'User can`t do this' do
  before do
    @user = create(:user) 
    visit root_path
    click_on 'Вход'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: 'password'
    click_on 'Войти'
    expect(page).to have_content 'Вход' 
    @card = create(:card, user: @user) 
    @user1 = create(:user, email: 'mail1@mail.com', password: 'password1', password_confirmation: 'password1')
    @card1 = create(:card, original_text: 'ja', translated_text: 'yes', user: @user1)         
  end
  
  scenario 'user can`t edit another users profile' do
    click_on 'Редактировать профиль'               
    expect(page).to_not have_content @user1.email                 
  end 
  
  scenario 'user can`t see another users cards' do
    click_on 'Все карточки'     
    expect(page).to_not have_content @card1.original_text          
  end   
  
  scenario 'user can`t check another users cards' do
    click_on 'Проверка'     
    expect(page).to_not have_content @card1.original_text      
  end   
end

feature 'Guests actions' do
  before do
    visit root_path    
  end
  
  scenario 'guest must see invitation to register or login' do
    expect(page).to have_content 'Привет, зарегистрируйтесь или войдите, чтобы продолжить'     
  end 
  
  scenario 'guest can`t edit another users profile' do
    expect(page).to_not have_content 'Редактировать профиль'    
  end 
  
  scenario 'guest can`t see cards' do
    click_on 'Все карточки'     
    expect(page).to_not have_content 'Показать'   
  end   
  
  scenario 'guest can`t check another users cards' do
    click_on 'Проверка'     
    expect(page).to_not have_content 'Слово'    
  end    
  
  scenario 'guest can`t create card' do  
    click_on 'Новая карточка'      
    expect(page).to_not have_content 'Создать'        
  end 
end



