class BookmarksController < ApplicationController

  def index
  end

  def create
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new(bookmark_params)
    if @bookmark.save
      SavedBookmark.create(list_id: @list.id, bookmark_id: @bookmark.id)
      GetThumbnails.call([@bookmark.id])
      flash[:notice] = "Bookmark successfully saved!"
      redirect_to :back
    else
      flash[:alert] = @bookmark.errors.full_messages.first
      redirect_to :back
    end
  end

  def new
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy
  end

  def bookmark_params
    params.require(:bookmark).permit(:name, :url)
  end

end