class AddBookmarkFromExtension

  def self.create_bookmark(list_id, bookmark_name, url)
    list = List.find(list_id)
    bookmark_info = [bookmark_name, url]
    new_bookmark = list.bookmarks.build(name: bookmark_name, url: url)
    list.save
    ParseUploadedBookmarks.save_snapshot_to_s3(new_bookmark, bookmark_info)
  end

end