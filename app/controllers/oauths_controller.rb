class OauthsController < ApplicationController
  skip_before_filter :require_login

  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    if @user = login_from(provider)
      p "Вход через #{provider.titleize}!"
      redirect_to root_path, :notice => "Вход через #{provider.titleize}!"
    else
      begin
        @user = create_from(provider)
        reset_session
        auto_login(@user)
        p "Вход через #{provider.titleize}!"
        redirect_to root_path, :notice => "Вход через #{provider.titleize}!"
      rescue
        p "Не удалось войти через #{provider.titleize}!"
        redirect_to root_path, :notice => "Не удалось войти через #{provider.titleize}!"
      end
    end
  end
end