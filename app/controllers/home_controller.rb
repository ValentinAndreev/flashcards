class HomeController < ApplicationController
  def showcard
    if current_user
      user = User.find(current_user.id)  
      @cardcheck = user.cards.randomcard
    end
    redirect_to cards_path if !@cardcheck 
  end
end