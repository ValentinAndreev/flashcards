require 'levenshtein'
# Check translation interactor
class CheckTranslation
  include Interactor

  def call
    @checks = context.card.checks
    @ef = context.card.ef
    context.errors = levens
    set_time(new_ef(q))
    context.card.checks += 1 unless context.errors.between?(1, 8)
    context.fail! if context.errors > 15
    context.card.save
  end

  def levens
    distance = Levenshtein.distance(context.card.translated_text, context.params[:text])
    percent = ((distance.to_f / context.card.translated_text.length.to_f) * 100)
  end

  def set_time(ef)
    next_time = if @checks == 0 then 24
      elsif @checks == 1 then 144
      else @ef*context.card.review_time
      end
    next_time = 0 if q == 4
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

  QUANTITY = {
      0..0 => 5,
      1..8 => 4,
      9..15 => 3,
      16..21 => 2,
      22..30 => 1
  }

  TIME = {
      0..10 => 0,
      11..720 => 1,
      721..1440 => 2,
      1441..2160 => 3,
      2161..3000 => 4      
  }

  def q
    q_levels = QUANTITY.find {|k, v| k.include?(levens) }&.last || 0
    time = TIME.find {|k, v| k.include?(context.params[:time].to_i) }&.last || 5
    q_levels = q_levels - time
    q_levels < 0 ? 0 : q_levels
  end
end
