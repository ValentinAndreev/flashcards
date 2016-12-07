class HomeController < ApplicationController
  def base
    @cardcheck = current_user.get_card if current_user
    redirect_to packs_path, notice: t(:No_cards_for_training) unless @cardcheck    
  end

  def showcard
    @cardcheck = current_user.get_card(params[:id]) if current_user
    redirect_to packs_path, notice: t(:No_cards_for_training) unless @cardcheck
  end

  def random
    @cardcheck = current_user.random_all if current_user
    redirect_to welcome_path, notice: t(:No_cards_for_training) unless @cardcheck
  end

  def welcome
  end
end