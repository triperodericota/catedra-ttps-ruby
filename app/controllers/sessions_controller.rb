class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]
  before_action :user_authenticated, only: [:new]

  def new
  end

  def create
    if login(params[:email], params[:password])
      flash[:success] = 'Welcome back!'
      redirect_to :controller => :courses, :action => :index
    else
      flash.now[:warning] = 'E-mail and/or password is incorrect.'
      render 'new'
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

end