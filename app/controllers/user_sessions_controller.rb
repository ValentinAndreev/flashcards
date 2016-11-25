class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]
  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_to root_path, notice: t(:Login) 
    else
      flash.now[:alert] =  t(:Cant_login) 
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: t(:Logout) 
  end
end
