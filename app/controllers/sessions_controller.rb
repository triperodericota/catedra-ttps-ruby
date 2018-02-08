class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]
  before_action :user_authenticated, only: [:new]
  before_action :set_errors

  def new
  end

  def create
    respond_to do |format|
      if login(params[:email], params[:password])
        format.html { redirect_to courses_url, notice: 'Bienvenido!' }
      else
        @errors << "El email y/o contraseña son incorrectos !"
        format.html { render 'new' }
      end
    end
  end

  def destroy
    logout
    flash[:success] = 'See you!'
    redirect_to log_in_path
  end

  def user_authenticated
    if logged_in?
      return redirect_to courses_path
    end
  end

  private

  def set_errors
    @errors = []
  end
end
