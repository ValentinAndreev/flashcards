class TrainersController < ApplicationController
  def review
    translation = Card.check_translation(params)
    if translation == 'right translation'
      flash.notice = 'Правильно'  
    else
      flash.notice = 'Не правильно. Правильно: '+ translation         
    end
    redirect_to root_path 
  end
end