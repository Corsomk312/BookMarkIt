class UploadController < ApplicationController

  def new
    @upload = Upload.new
  end

  def create
    @bookmark_html = params[:upload][:upload_file_name].read
    ParseUploadedBookmarksFile.call(@bookmark_html, current_user)
    redirect_to user_path(current_user)
  end

  def destroy

  end

private
  def file_upload_params
    params.require(:upload).permit(:upload_file_name, :upload_content_type, :upload_file_size)
  end

end
