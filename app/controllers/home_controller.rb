class HomeController < ApplicationController
  def showcard
    @cardcheck = Card.randomcard
  end
end
