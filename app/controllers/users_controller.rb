# UserController
class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to root_path, notice: t(:Profile_was_changed)
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path, notice: t(:User_was_deleted)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
