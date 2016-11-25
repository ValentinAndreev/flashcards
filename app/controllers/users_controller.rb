class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :require_login, only: [ :new, :create]

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
      if @user.save
         login(user_params[:email], user_params[:password])
         redirect_to root_path, notice: 'Успешная регистрация и вход'
      else
        render :new 
      end
  end

  def update
    if @user.update(user_params)
      redirect_to root_path, notice: 'Вы изменили свой профиль' 
    else
      render :edit 
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path, notice: 'Пользователь был удален' 
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
