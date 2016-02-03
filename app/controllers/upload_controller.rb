class UploadController < ApplicationController

  def new
    if current_user
      @upload = Upload.new
    else
      flash[:alert] = "You must be logged in to upload your bookmarks!"
      redirect_to :root
    end
  end

  def create
    if params[:upload]
      @bookmark_html = params[:upload][:upload_file_name].read
      if ParseBookmarks.call(@bookmark_html, current_user) == false
        flash[:alert] = "Invalid or empty file!"
        redirect_to :new_upload
      else
        redirect_to user_path(current_user)
      end
    else
      flash[:alert] = "You need to select a file first!"
      redirect_to :new_upload
    end
  end

  def destroy

  end

private
  def file_upload_params
    params.require(:upload).permit(:upload_file_name, :upload_content_type, :upload_file_size)
  end

end
