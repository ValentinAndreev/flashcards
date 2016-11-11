class CardsController < ApplicationController
    
  def index
    @card = Card.all    
  end
  
  def show
    @card = Card.find(params[:id])
  end
  
  def new
    @card = Card.new
  end
  
  def create
    @card = Card.new(card_params)
    @card.original_text.capitalize!
    @card.translated_text.capitalize!
    if (@card.original_text != @card.translated_text) && @card.save    
      redirect_to action: 'index'
    else
      render 'new'
    end    
  end
  
  def edit
    @card = Card.find(params[:id])    
  end
  
  def update
    @card = Card.find(params[:id])    
    @card.original_text.capitalize!
    @card.translated_text.capitalize!
    if (@card.original_text != @card.translated_text) && @card.update(card_params)  
      redirect_to action: 'index'
    else
      render 'edit'
    end      
  end
  
  def destroy
    @card = Card.find(params[:id])
    @card.destroy    
    redirect_to action: 'index'      
  end
  
  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date)
  end 
end
