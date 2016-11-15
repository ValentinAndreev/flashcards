class TrainersController < ApplicationController
  def review
    card = Card.find(params[:id])
    if card.translated_text == params[:text] then
      flash.notice = 'Правильно'  
      card.review_date = 3.days.from_now.to_date
      card.save
    else
      flash.notice = 'Не правильно. Правильно: '+ card.translated_text          
    end
    redirect_to root_path 
  end
end
