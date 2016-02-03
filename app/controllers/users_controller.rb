class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
    @errors = @user.errors.full_messages
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Successfully registered and logged in!"
      session[:user_id] = @user.id
      redirect_to current_user
    else
      flash[:alert] = @user.errors.full_messages.first
      redirect_to :new_user
    end
  end

  def edit
    @user = User.find(params[:id])
    if current_user != @user
      flash[:alert] = "You can only edit your own profile!"
      redirect_to @user
    end
  end

  def show
    @user = User.find(params[:id])
    case params[:sort]
    when "name"
      @lists = @user.lists_by_name
    when "age"
      @lists = @user.lists_by_age
    when "popularity"
      @lists = @user.lists_by_popularity
    when "size"
      @lists = @user.lists_by_size
    else
      @lists = @user.lists.reverse
    end
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

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

end
