require 'rails_helper'
require 'support/factory_girl'

def t(string, options={})
  I18n.t(string, options)
end

feature 'acceptance check' do

  before do
    @user = create(:user)
    @pack = create(:pack, user: @user, base: true)
    @card = create(:card, pack: @pack, user_id: @user.id) 
    visit welcome_path     
    click_on t('Login')
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: 'password'
    click_on t('Log')    
    expect(page).to have_content @user.email     
    visit showcard_path      
  end

  scenario '5 right translations' do 
    p 'factory'
    p @card.review_date
    expect(page).to have_content 'nicht'
    fill_in t('Translated_text'), with: 'not'
    click_on t('Send') 
    expect(page).to have_content t('This_pack_have_no_cards_with_review_date')  
    p 'changed date'
    p @card.review_date
    Timecop.travel(@card.review_date.to_time)
    p 'timecop'
    p Time.now
  end
end