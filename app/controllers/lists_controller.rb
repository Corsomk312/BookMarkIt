class ListsController < ApplicationController

  def create
    @user = current_user
    @list = @user.lists.new(list_params)
    if @list.save
      flash[:notice] = "List successfully created!"
      redirect_to @user
    else
      flash[:alert] = @list.errors.full_messages.first
      redirect_to :new_list
    end
  end

  def new
    if current_user
      @list = List.new
    else
      flash[:notice] = "You must login to create a new form!"
      redirect_to :login
    end
  end

  def edit
    @list = List.find(params[:id])
  end

  def show
    @list = List.find(params[:id])
    @bookmarks = Bookmark.all
  end

  def update
    @list = List.find(params[:id])
    if @list.update_attributes(list_params)
      flash[:notice] = "List name successfully updated!"
      redirect_to @list
    else
      flash[:alert] = "List failed to save"
      redirect_to @list
    end
  end

  def destroy
    puts params
    @list = List.find(params[:id])
    @list.destroy
    redirect_to current_user
  end

  def list_params
    params.require(:list).permit(:name)
  end

end
