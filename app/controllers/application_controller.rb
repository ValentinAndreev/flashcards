# ApplicatinController
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_locale

  def set_locale
    locale = current_user&.locale || params[:locale] || session[:locale] || http_accept_language.compatible_language_from(I18n.available_locales)
    if current_user&.locale && params[:locale]
      locale = params[:locale]
      current_user.update_column(:locale, params[:locale])
    end
    if locale && I18n.available_locales.include?(locale.to_sym)
      session[:locale] = I18n.locale = locale.to_sym
    end
  end
end
