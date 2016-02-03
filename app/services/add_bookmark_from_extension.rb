class AddBookmarkFromExtension

  def self.create_bookmark(list_id, bookmark_name, url)
    list = List.find(list_id)
    bookmark_info = [bookmark_name, url]
    new_bookmark = Bookmark.new(name: bookmark_name, url: url)
    new_bookmark.save
    ParseBookmarks.save_snapshot_to_s3(new_bookmark)
    saved_bookmark = SavedBookmark.create(list_id: list.id, bookmark_id: new_bookmark.id)
  end

end