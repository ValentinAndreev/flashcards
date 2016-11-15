class HomeController < ApplicationController
  def showcard
    @cardcheck = Card.randomcard
    @@card = @cardcheck
  end
  
  def reciveanswer
    if @@card.translated_text == params[:text] then
      flash.notice = 'Правильно'  
      @@card.review_date = 3.days.from_now.to_date
      @@card.save
      redirect_to root_path
    else
      flash.notice = 'Не правильно. Правильно: '+ @@card.translated_text      
      redirect_to root_path      
    end
  end
  
  def card_params
    params.require(:text)
  end 
end
