# OauthsController
class OauthsController < ApplicationController
  skip_before_filter :require_login

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    @user = login_from(auth_params[:provider])
    if @user
      @message = t(:Login_from_twitter)
    else
      begin
        @user = create_from(provider)
        reset_session
        auto_login(@user)
        @message = t(:Login_from_twitter)
      rescue
        @message = t(:Cant_login_from_twitter)
      end
    end
    redirect_to welcome_path, notice: @message
  end

  private

  def auth_params
    params.permit(:code, :provider)
  end
end
