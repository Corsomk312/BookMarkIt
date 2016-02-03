class SessionsController < ApplicationController

  def new
    redirect_to :root
    flash[:notice] = "Please login using the navbar"
  end

  def create
    @user = User.find_by(username: params[:session][:username])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:notice] = "Successfully logged in!"
      redirect_to current_user
    else
      flash[:notice] = "Username/password combination does not match"
      redirect_to :root
    end
  end

  def destroy
    if current_user
      session.clear
      flash[:notice] = "Logged out"
    else
      flash[:alert] = "Already logged out!"
    end
    redirect_to :root
  end

  def demolish
    session.clear
    redirect_to :root
  end

end
