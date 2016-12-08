class TrainersController < ApplicationController
  def review
    card = Card.find(params[:id])
    translation = CheckTranslation.call(card: card, params: params)
    if translation.success?
      flash.notice = t(:You_are_right) 
    else
      flash.notice = t(:You_are_wrong_right_translation_is) + card.translated_text
    end
    redirect_to :back
  end
end