require 'rails_helper'
require 'support/factory_girl'

def t(string, options={})
  I18n.t(string, options)
end

feature 'Check all translations' do 
  let!(:real_date) { Time.now.strftime('%F %H').to_datetime }

  before do
    @user = create(:user)
    @pack = create(:pack, user: @user)
    @card = create(:card, pack: @pack, user_id: @user.id)   
    visit welcome_path     
    click_on t('Login')
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: 'password'
    click_on t('Log')    
    expect(page).to have_content @user.email          
  end

  scenario 'all right translations' do 
    move_time = [0, 12, 72, 168, 336, 672]
    i=0
      p 'Nowdat:'+real_date.to_s
    6.times {
      p 'Review:'+Card.find(@card.id).review_date.to_s
      Timecop.travel(move_time[i].hours.from_now)
      p 'Timecp:'+Time.now.to_datetime.to_s
      visit showcard_path   
      expect(page).to have_content 'nicht'
      fill_in t('Translated_text'), with: 'not'
      click_on t('Send')  
      expect(page).to have_content t('This_pack_have_no_cards_with_review_date')      
      Timecop.return   
      i+=1
    }
  end
end 