class HomeController < ApplicationController
  def showcard
    @cardcheck = Card.randomcard
    redirect_to cards_path if !@cardcheck 
  end
end
