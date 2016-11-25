class HomeController < ApplicationController
  def showcard
    @cardcheck = current_user.cards.randomcard if current_user
    redirect_to cards_path unless @cardcheck 
  end
end