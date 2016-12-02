class HomeController < ApplicationController
  def showcard
    @pack = current_user.packs.find(params[:id])
    @cardcheck = @pack.cards.randomcard if @pack
    unless @cardcheck
      redirect_to packs_path, notice: t(:No_cards_for_training)
    end
  end
end