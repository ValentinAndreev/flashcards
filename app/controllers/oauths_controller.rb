class OauthsController < ApplicationController
  skip_before_filter :require_login

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    if @user = login_from(provider)
      redirect_to root_path, notice: t(:Login_from_twitter)
    else
      begin
        @user = create_from(provider)
        reset_session
        auto_login(@user)
        redirect_to root_path, notice: t(:Login_from_twitter)
      rescue
        redirect_to root_path, notice: t(:Cant_login_from_twitter)
      end
    end
  end
  
 private
 def auth_params
   params.permit(:code, :provider)
 end
end