require 'levenshtein'

class CheckTranslation
  include Interactor

  def call
    if context.card.translated_text == context.params[:text]
      context.card.right_checks += 1 if context.card.right_checks < 5
      context.card.review_date += set_time.hours if context.card.right_checks.nonzero?
      context.card.save
    else
      levens = Levenshtein.distance(context.card.translated_text, context.params[:text])
      if levens>1
        context.errors = t(:You_are_wrong_right_translation_is) + context.card.translated_text
      else
        context.errors = "#{t(:Wrong_typed_word)}: #{context.params[:text]} #{t(:must_be)}: #{context.card.translated_text}"
      end
      if context.card.wrong_checks < 2
        context.card.wrong_checks += 1 if context.card.right_checks > 0  
      else
        context.card.wrong_checks = 0
        context.card.right_checks -= 1 if context.card.right_checks > 0
        context.card.review_date -= set_time.hours if context.card.right_checks.nonzero?     	
      end
      context.card.save      
      context.fail!
    end
  end

  def set_time
    move_time = [0, 12, 72, 168, 336, 672]
    move_time[context.card.right_checks]
  end

  def t(string, options={})
    I18n.t(string, options)
  end
end