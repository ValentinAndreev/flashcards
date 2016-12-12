class CheckTranslation
  include Interactor

  def call
    if context.card.translated_text == context.params[:text]
      context.card.right_checks += 1 if context.card.right_checks<5
      context.card.review_date = set_time.hours.from_now if context.card.right_checks != 0 && set_time
      context.card.save
    else
      if context.card.wrong_checks<2
        context.card.wrong_checks += 1 if context.card.right_checks>0  
      else
        context.card.wrong_checks = 0
        context.card.right_checks -= 1 if context.card.right_checks>0
        context.card.review_date = set_time.hours.from_now if context.card.right_checks != 0 && set_time       	
      end
      context.card.save      
      context.fail!
    end
  end

  def set_time
    case context.card.right_checks
      when 0
        move_time = 0
      when 1
        move_time = 12
      when 2
        move_time = 72
      when 3
        move_time = 168
      when 4
        move_time = 336    
      when 5
        move_time = 672                      
    end
  end
end