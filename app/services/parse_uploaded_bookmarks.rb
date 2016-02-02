include CurrentUserHelper # can probably remove this module, as it doesn't work in Services

class ParseUploadedBookmarks

  def self.call(file, user)
    stuff = Nokogiri::HTML(file)
    uncategorized = stuff.xpath('//a[@href]').map {|link| [link.text.strip, link["href"]]} - stuff.xpath('//dl/dl/dl//a[@href]').map {|link| [link.text.strip, link["href"]]}
    stuff_in_folders = stuff.xpath('//dl/dl/dl').map {|x| x.search('./dt//a[@href]').map {|link| [link.text.strip, link["href"]]}}
    folder_headings = stuff.xpath('//h3').map {|thing| thing.text}[1..-1]
    return false if uncategorized == [] && stuff_in_folders == []

    self.create(uncategorized, stuff_in_folders, folder_headings, user)
  end

  def self.create(uncategorized, stuff_in_folders, folder_headings, user)
    if uncategorized.length > 0
      if user.lists.where(name: "uncategorized").length > 0
        new_list = user.lists.where(name: "uncategorized").first
      else
        new_list = user.lists.create(name: "uncategorized")
      end
      uncategorized.each do |bookmark_info|
        if Bookmark.where(name: bookmark_info[0], url: bookmark_info[1]).length == 0
          new_bookmark = Bookmark.new(name: bookmark_info[0], url: bookmark_info[1])
          if new_bookmark.save
            save_snapshot_to_s3(new_bookmark)
          end
          new_list.saved_bookmarks.create(bookmark_id: new_bookmark.id)

        else
          new_list.saved_bookmarks.create(bookmark_id: Bookmark.where(name: bookmark_info[0], url: bookmark_info[1]).first.id)
        end
      end
    end

    if stuff_in_folders.length > 0
      folder_headings.each_with_index do |heading, index|
        new_list = user.lists.create(name: heading)
        if stuff_in_folders[index].length > 0
          stuff_in_folders[index].each do |bookmark_info|
            if Bookmark.where(name: bookmark_info[0], url: bookmark_info[1]).length == 0
              new_bookmark = Bookmark.new(name: bookmark_info[0], url: bookmark_info[1])
              save_snapshot_to_s3(new_bookmark)
              new_list.saved_bookmarks.create(bookmark_id: new_bookmark.id)

            else
              new_list.saved_bookmarks.create(bookmark_id: Bookmark.where(name: bookmark_info[0], url: bookmark_info[1]).first.id)
            end
          end
        end
      end
    end

  end


  def self.save_snapshot_to_s3(new_bookmark)
    file = File.open(AddSnapshot.call(new_bookmark.url))
    new_snapshot = Snapshot.new(bookmark_id: new_bookmark.id)
    # or: pass snap args there! ^^^^
    new_snapshot.thumbnail = file # snapshot.save
    file.close
    new_snapshot.save! # snapshot.save
  end

  def self.parse(urls)
    urls.each do |url|
      ParseURI.call(url);
    end
  end

end
