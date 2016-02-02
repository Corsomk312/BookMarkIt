class DisplaySnapshot

  def self.call(bookmark)
  image_data = bookmark.name
  image = bookmark.thumbnail
  send_data(image,
    :filename => image_data+".jpg",
    :type => "image/jpg",
    :disposition => "inline")
  end
end