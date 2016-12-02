class HomeController < ApplicationController
  def showcard
  	if current_user
      @pack = current_user.packs.find(params[:id]) if params[:id]
      if @pack
        @cardcheck = @pack.cards.randomcard
      else
        @cardcheck = Pack.basepack.cards.randomcard if Pack.basepack
      end 
    end
    redirect_to welcome_path, notice: t(:No_cards_for_training) unless current_user && @cardcheck
  end
end