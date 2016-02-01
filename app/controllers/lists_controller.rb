class ListsController < ApplicationController

  def create
    @user = current_user
    if params[:list][:list_to_dup]
      old_list = List.find(params[:list][:list_to_dup].to_i)
      @list = old_list.dup
      @list.update_attributes(creator_id: @user.id)
      old_list.saved_bookmarks.to_a.each do |saved_bookmark|
        new_saved_bookmark = saved_bookmark.dup
        new_saved_bookmark.update_attributes(list_id: @list.id)
      end
      flash[:notice] = "Successfully added list!"
      redirect_to :back
    else
      @list = @user.lists.new(list_params)
      if @list.save
        flash[:notice] = "List successfully created!"
        redirect_to @user
      else
        flash[:alert] = @list.errors.full_messages.first
        redirect_to :new_list
      end
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
    case params[:sort]
    when "name"
      @bookmarks = @list.bookmarks_by_name
    when "age"
      @bookmarks = @list.bookmarks_by_age
    when "length"
      @bookmarks = @list.bookmarks_by_length
    else
      @bookmarks = @list.bookmarks
    end
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
    params.require(:list).permit(:name, :list_to_dup)
  end

end
