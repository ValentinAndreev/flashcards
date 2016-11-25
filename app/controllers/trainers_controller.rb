class TrainersController < ApplicationController
  def review
    user = User.find(current_user.id)  
    card = user.cards.find(params[:id])
    translation = CheckTranslation.call(card: card, params: params)
    if translation.success?
      flash.notice = 'Правильно.'  
    else
      flash.notice = 'Не правильно. Правильно: '+ card.translated_text   
    end
    redirect_to showcard_path 
  end
end