# TrainersController
class TrainersController < ApplicationController
  def review
    card = Card.find(params[:id])
    translation = CheckTranslation.call(card: card, params: params)
    if translation.success?
      flash.notice = t(:You_are_right)+t(:deviation, prc: translation.errors.round) 
    else
      flash.notice = t(:You_are_wrong_right_translation_is)+card.translated_text+t(:deviation, prc: translation.errors.round)
    end
    redirect_to showcard_path
  end
end
