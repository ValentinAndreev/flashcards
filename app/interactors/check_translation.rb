class CheckTranslation
  include Interactor

  def call
    if context.card.translated_text == context.params[:text] then
      move_time = 0
      case context.card.right_checks
        when 0
          move_time = 12
        when 1
          move_time = 72
        when 2
          move_time = 168
        when 3
          move_time = 336
        when 4
          move_time = 672                
      end
      context.card.right_checks += 1 if context.card.right_checks<5
      context.card.review_date = move_time.hours.from_now if move_time != 0
      context.card.save
    else
      if context.card.wrong_checks<2
        context.card.wrong_checks += 1  
      else
        context.card.wrong_checks = 0
        context.card.right_checks = 1
        context.card.review_date = 12.hours.from_now         	
      end
      context.card.save      
      context.fail!
    end
  end
end