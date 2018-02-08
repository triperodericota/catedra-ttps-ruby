class UsersController < ApplicationController

  skip_before_action :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        login(params[:email], params[:password])
        format.html { redirect_to root_url, notice: "Bienvenido #{@user.first_name} !" }
      else
        format.html { render 'new' }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
