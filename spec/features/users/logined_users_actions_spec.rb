require 'rails_helper'
require 'support/factory_girl'

def t(string, options={})
  I18n.t(string, options)
end

feature 'Logined user actions' do   
  let!(:user) { create(:user, password: 'password') } 
  let!(:pack) { create(:pack, user: user, base: false) }   
  let!(:card) { create(:card, pack: pack, user_id: user.id) }  

  before do
    visit welcome_path
    click_on t('Login')
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_on t('Log')
    expect(page).to have_content user.email
  end
  
  scenario 'users logout' do
    click_on t('Logout')
    expect(page).to have_content t('Hello_you_must_register_or_login_to_continue')      
  end   
  
  scenario 'user can edit own profile' do  
    click_on t('Edit_profile') 
    fill_in 'Email', with: 'mail1@mail.com'
    fill_in 'Password', with: 'password1'   
    fill_in 'Password confirmation', with: 'password1'        
    click_on 'Update User'  
    visit welcome_path   
    expect(page).to have_content 'mail1@mail.com'
  end
  
  scenario 'user can create card' do   
    pack = card.pack
    user = pack.user 
    click_on t('All_packs')      
    click_on t('All_cards')     
    expect(page).to have_content t('Show')        
  end 
    
  scenario 'user can edit own cards' do
    card.translated_text = 'yes'
    card.save
    click_on t('All_packs')      
    click_on t('All_cards')   
    click_on t('Show')     
    click_on t('Edit') 
    fill_in 'Translated text', with: 'not'
    click_on 'Update Card'   
    expect(page).to have_content('not')     
  end 

  scenario 'user can delete own cards' do
    click_on t('All_packs')       
    click_on t('All_cards')  
    click_on t('Show')     
    click_on t('Delete')  
    expect(page).to_not have_content('not')    
  end 
  
  scenario 'user can see check page' do
    click_on t('All_packs')       
    click_on t('All_cards')     
    click_on t('Training')      
    expect(page).to have_content t('Word')      
  end      

  scenario 'test of attached image' do     
    expect(card.image_file_name).to eq ('cat.jpg')
  end     

  scenario 'user can create pack' do   
    user = pack.user
    click_on t('All_packs')     
    expect(page).to have_content t('Name')    
  end 

  scenario 'user can delete pack' do   
    click_on t('All_packs') 
    click_on t('Delete')  
    expect(page).to_not have_content t('Name')    
  end 

  scenario 'user can rename pack' do   
    click_on t('All_packs') 
    click_on t('Rename') 
    expect(page).to have_content t('Rename')      
  end 

  scenario 'user can make pack base' do
    click_on t('All_packs') 
    click_on t('Add')
    expect(page).to have_content t('Pack_was_made_base')     
  end

  scenario 'user can remove pack from base' do
    click_on t('All_packs') 
    click_on t('Add')
    click_on t('Remove')  
    expect(page).to have_content t('Pack_was_removed_from_base')    
  end
  
  scenario 'user must be redirected to training' do   
    expect(page).to have_content t('Word')   
  end
end  