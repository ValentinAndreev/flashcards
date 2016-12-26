require 'levenshtein'
# Check translation interactor
class CheckTranslation
  include Interactor

  def call
    @review_time = context.card.review_time
    @text = context.card.translated_text
    @checks = context.card.checks
    @timer = context.params[:time].to_i
    @ef = context.card.ef
    if @text == context.params[:text] 
      right_answer 
      context.card.checks += 1      
    else 
      wrong_answer
    end
      context.card.save
  end

  def levens
    text = context.card.translated_text
    distance = Levenshtein.distance(text, context.params[:text])
  end

  def set_time(ef)
    next_time = if @checks == 0 then 24
      elsif @checks == 1 then 144
      else @ef*@review_time
      end
    context.card.review_date = next_time.ceil.hours.from_now
    context.card.review_time = next_time.ceil   
  end

  def new_ef(q)  
    @ef += (0.1-(5-q)*(0.08+(5-q)*0.02))
    @ef = 1.3 if @ef < 1.3
    if q < 3
      @checks = 0
    end
    @ef = 2.5 if @checks < 2
    context.card.ef = @ef
  end

  def right_answer
    q = if @timer < 3 then 5
      elsif @timer < 6 then 4
      else 3
      end
    set_time(new_ef(q))  
  end

  def wrong_answer
    q = if levens == 1 then 2
      elsif levens == 2 then 1
      else 0
      end    
    context.errors = levens
    set_time(new_ef(q))
    context.fail!
  end
end
