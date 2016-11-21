class TrainersController < ApplicationController
  def review
    card = Card.find(params[:id])
    translation = CheckTranslation.call(card: card, params: params)
    if translation.success?
      flash.notice = 'Правильно.'  
    else
      flash.notice = 'Не правильно. Правильно: '+ card.translated_text   
    end
    redirect_to root_path 
  end
end