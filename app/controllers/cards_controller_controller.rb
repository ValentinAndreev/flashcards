class CardsControllerController < ApplicationController
  def index
    @cards = Card.all
  end
end
