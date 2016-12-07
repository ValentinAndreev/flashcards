class HomeController < ApplicationController
  def showcard
    @cardcheck = current_user.get_card(params[:id]) if current_user 
    redirect_to welcome_path, notice: t(:No_cards_for_training) unless @cardcheck
  end
end