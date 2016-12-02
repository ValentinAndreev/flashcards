class CardsController < ApplicationController
  before_action :set
  before_action :require_login
    
  def index
    @card = @pack.cards.all    
  end
  
  def show
  end
  
  def new
    @card = @pack.cards.new
  end
  
  def create
    @card = @pack.cards.new(card_params)
    if @card.save    
      redirect_to pack_cards_path
    else
      render 'new'
    end    
  end
  
  def edit 
  end
  
  def update   
    if @card.update(card_params)  
      redirect_to pack_cards_path
    else
      render 'edit'
    end      
  end
  
  def destroy
    @card.destroy    
    redirect_to pack_cards_path  
  end

  private
  
  def set
      @pack = current_user.packs.find(params[:pack_id]) if params[:pack_id] && current_user  
      @card = @pack.cards.find(params[:id]) if params[:id] && @pack 
  end
  
  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date, :image)
  end 
end