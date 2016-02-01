class SavedBookmarksController < ApplicationController

  def destroy
    @list = List.find(params[:list_id])
    @saved_bookmark = SavedBookmark.find(params[:saved_bookmark_id])
    @saved_bookmark.destroy
    redirect_to :edit_list
  end

end
