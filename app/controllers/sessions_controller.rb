class SessionsController < ApplicationController

  def new
    redirect_to :root
    flash[:notice] = "you may login from the homepage!"
  end

  def create
    @user = User.find_by(username: params[:session][:username])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:notice] = "Successfully logged in!"
      redirect_to current_user
    else
      flash[:notice] = "username/password combination does not match"
      redirect_to :root
    end
  end

  def destroy
    session.clear
    flash[:notice] = "Logged out"
    redirect_to :root
  end

  # def show
  # end

end
