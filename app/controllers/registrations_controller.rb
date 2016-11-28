class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
      if @user.save
         login(user_params[:email], user_params[:password])
         redirect_to root_path, notice: t(:Succesfully_registered_and_entered)
      else
        render :new 
      end
  end
  
  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
