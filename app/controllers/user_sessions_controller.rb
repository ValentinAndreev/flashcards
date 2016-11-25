class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]
  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_to root_path, notice: 'Успешный вход'
    else
      flash.now[:alert] = 'Войти не удалось'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: 'Успешный выход'
  end
end
