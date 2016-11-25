class TrainersController < ApplicationController
  def review
    user = User.find(current_user.id)  
    card = user.cards.find(params[:id])
    translation = CheckTranslation.call(card: card, params: params)
    if translation.success?
      flash.notice = t(:You_are_right) 
    else
      flash.notice = t(:You_are_wrong. Right_translation_is:) + card.translated_text   
    end
    redirect_to showcard_path 
  end
end