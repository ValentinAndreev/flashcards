require '/home/z/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/levenshtein-c-0.1.0/lib/levenshtein.so'

class TrainersController < ApplicationController
  def review
    card = Card.find(params[:id])
    translation = CheckTranslation.call(card: card, params: params)
    if translation.success?
      flash.notice = t(:You_are_right) 
    else
      levens = Levenshtein.distance(card.translated_text, params[:text])
      if levens>1
        flash.notice = t(:You_are_wrong_right_translation_is)+card.translated_text
      else
        flash.notice = "#{t(:Wrong_typed_word)}: #{params[:text]} #{t(:must_be)}: #{card.translated_text}"
      end
    end
    redirect_to showcard_path
  end
end