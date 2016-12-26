# TrainersController
class TrainersController < ApplicationController
  def review
    card = Card.find(params[:id])
    check_type = current_user.select_card[1]
    translation = CheckTranslation.call(card: card, params: params, check_type: check_type)
    if translation.success? 
      flash.notice = t(:You_are_right)
    elsif check_type != I18n.t(:Repeating_cards)
      flash.notice =  t(:You_are_wrong_right_translation_is)+card.translated_text
    else
      flash.notice = translation.errors
    end
    redirect_to showcard_path
  end
end
