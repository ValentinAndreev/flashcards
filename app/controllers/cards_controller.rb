class CardsController < ApplicationController
  before_action :set
  before_action :require_login
    
  def index
    @card = current_user.cards.all    
  end
  
  def show
  end
  
  def new
    @card = current_user.cards.new
  end
  
  def create
    @card = current_user.cards.new(card_params)
    if @card.save    
      redirect_to cards_path
    else
      render 'new'
    end    
  end
  
  def edit 
  end
  
  def update   
    if @card.update(card_params)  
      redirect_to cards_path
    else
      render 'edit'
    end      
  end
  
  def destroy
    @card.destroy    
    redirect_to cards_path   
  end

  private
  
  def set
      @card = current_user.cards.find(params[:id]) if params[:id] && current_user  
  end
  
  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date)
  end 
end
