class CardsController < ApplicationController
  def index
    @card = Card.all    
  end
end
