class UsersController < ApplicationController

  def new
    @user = User.new
    @errors = @user.errors.full_messages
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to :login
    else
      flash[:alert] = @user.errors.full_messages.first
      redirect_to :new_user
    end
  end

  def edit
    @user = User.find(params[:id])
    if current_user != @user
      flash[:alert] = "You can only edit your own profile!"
      redirect_to current_user
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    if current_user.update_attributes(edit_user_params)
      flash[:notice] = "Successfully updated profile!"
      redirect_to current_user
    end
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :first_name, :last_name)
  end

  def edit_user_params
    params.require(:user).permit(:email, :first_name, :last_name)
  end

end