# HomeController
class HomeController < ApplicationController
  def showcard
    @cardcheck = current_user.select_card
    redirect_to packs_path, notice: t(:No_cards_for_training) unless @cardcheck[0]
  end

  def set_locale
    if current_user && params[:locale]
      current_user.locale = I18n.locale = params[:locale]
      current_user.save
    elsif params[:locale]
      I18n.locale = params[:locale]
    else
      I18n.locale = http_accept_language.compatible_language_from(I18n.available_locales)
    end
    redirect_to welcome_path
  end

  def welcome
    I18n.locale = current_user.locale if current_user&.locale
  end
end
