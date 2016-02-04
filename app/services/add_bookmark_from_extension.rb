class AddBookmarkFromExtension

  def self.create_bookmark(list_id, bookmark_name, url)
    list = List.find(list_id)
    new_bookmark = Bookmark.new(name: bookmark_name, url: url)
    new_bookmark.save
    book_id = [new_bookmark.id]
    GetThumbnails.call(book_id)
    saved_bookmark = SavedBookmark.create(list_id: list.id, bookmark_id: new_bookmark.id)
  end

end