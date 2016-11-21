class CheckTranslation
  include Interactor

  def call
    if context.card.translated_text == context.params[:text] then
       context.card.review_date = 3.days.from_now.to_date
       context.card.save
    else
       context.fail!
    end
  end
end