# HomeController
class HomeController < ApplicationController
  def showcard
    @cardcheck = current_user.select_card
    redirect_to packs_path, notice: t(:No_cards_for_training) unless @cardcheck[0]
  end

  def welcome
    if current_user
      I18n.locale = current_user.locale
      redirect_to showcard_path if current_user
    end
  end
end
