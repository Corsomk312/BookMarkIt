class ExtensionController < ApplicationController
  # before_action :authenticate
skip_before_action :verify_authenticity_token


  def create
    @user = User.find_by(username: params[:username])

    # response["user_id"] = @user.id.to_s
    # render :nothing => true
    render :json => { user_id: @user.id}
  end

  def new
    response["X-Authentication-Token"] = generate_auth_token
  end

  def show
    @user = User.find(params[:user_id])
    @list = @user.lists

    @list_info = @list.map do |list|
      [list.name, list.id]
    end
    render :json => {listArray: @list_info}
  end

  def new_bookmark
    puts params
    @list = List.find(params[:list_id])


    # @list.bookmarks.build(name: params[:bookmark_name][:name])
    # @list.save

  end

  protected

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      User.find_by(auth_token: token)
    end
  end

  private

  def generate_auth_token
    SecureRandom.uuid.gsub(/\-/,'')
  end

end
