require 'levenshtein'
# Check translation interactor
class CheckTranslation
  include Interactor

  def call
    text = context.card.translated_text
    right = context.card.right_checks
    text == context.params[:text] ? right_answer(right) : wrong_answer(right)
    context.card.save
  end

  def levens
    text = context.card.translated_text
    distance = Levenshtein.distance(text, context.params[:text])
    distance > 1 ? t(:You_are_wrong_right_translation_is) + text : t(:Wrong_typed, mistake: context.params[:text], text: text)
  end

  def set_time
    time = [0, 12, 72, 168, 336, 672]
    time[context.card.right_checks]
  end

  def t(string, options = {})
    I18n.t(string, options)
  end

  def right_answer(right)
    context.card.right_checks += 1 if right < 5
    move_time
  end

  def wrong_answer(right)
    context.errors = levens
    if context.card.wrong_checks < 2
      context.card.wrong_checks += 1 if right > 0
    else
      context.card.wrong_checks = 0
      context.card.right_checks -= 1 if right > 0
      move_time
    end
    context.fail!
  end
  
  def move_time
    context.card.review_date = set_time.hours.from_now if context.card.right_checks.nonzero?
  end
end
