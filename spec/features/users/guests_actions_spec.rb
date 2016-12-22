require 'rails_helper'
require 'support/factory_girl'

def t(string, options={})
  I18n.t(string, options)
end

feature 'Guests actions' do
  before do
    visit packs_path    
  end
  
  scenario 'guest must see invitation to register or login' do
    expect(page).to have_content t('Hello_you_must_register_or_login_to_continue')     
  end 
  
  scenario 'guest can`t edit another users profile' do
    expect(page).to_not have_content t('Edit_profile')    
  end 
  
  scenario 'guest can`t see packs and cards' do    
    expect(page).to_not have_content t('All_cards')     
  end   

  scenario 'guest can change the language' do
    if I18n.available_locales.count > 1
      old_locale = I18n.available_locales[0]
      I18n.locale = old_locale
      new_locale = I18n.available_locales[1]
      click_on t(:Change_language, lang: new_locale), locale_path(new_locale)
      expect(I18n.locale).to_not eq(old_locale)
    end
  end
end