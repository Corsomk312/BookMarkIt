class SessionsController < ApplicationController

  def new
  end

  def create

    @user = User.find_by(username: params[:session][:username])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to current_user
    else
      flash[:notice] = "username/password combination does not match"
      redirect_to :login
    end
  end

  def destroy
    session.clear
    redirect_to :root
  end

  def show

  end

end
