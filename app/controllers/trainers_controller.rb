# TrainersController
class TrainersController < ApplicationController
  def review
    card = Card.find(params[:id])
    translation = CheckTranslation.call(card: card, params: params)
    translation.success? ? flash.notice = t(:You_are_right) : flash.notice =  t(:You_are_wrong_right_translation_is)+card.translated_text
    redirect_to showcard_path
  end
end
