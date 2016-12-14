class CheckTranslation
  include Interactor

  def call
    if context.card.translated_text == context.params[:text]
      context.card.right_checks += 1 if context.card.right_checks<5
      context.card.review_date += set_time.hours if context.card.right_checks != 0
      context.card.save
    else
      if context.card.wrong_checks<2
        context.card.wrong_checks += 1 if context.card.right_checks>0  
      else
        context.card.wrong_checks = 0
        context.card.right_checks -= 1 if context.card.right_checks>0
        context.card.review_date -= set_time.hours if context.card.right_checks != 0      	
      end
      context.card.save      
      context.fail!
    end
  end

  def set_time
    move_time = [0, 12, 72, 168, 336, 672]
    move_time[context.card.right_checks]
  end
end