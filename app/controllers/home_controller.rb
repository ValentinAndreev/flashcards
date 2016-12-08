class HomeController < ApplicationController

  def showcard
    @cardcheck = current_user.selectcard(params[:id].to_i)
    redirect_to packs_path, notice: t(:No_cards_for_training) unless @cardcheck    
  end

  def welcome
    redirect_to showcard_path if current_user
  end
end