# UserSessions
class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
    @user = User.new
  end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_to root_path, notice: t(:Succesfully_logined)
    else
      flash.now[:alert] = t(:Cant_login)
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: t(:Logout)
  end
end
