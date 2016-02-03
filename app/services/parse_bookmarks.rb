class ParseBookmarks

  def self.call(file, user)
    stuff = Nokogiri::HTML(file)
    # thumblist = books.css("a").map { |link| link['href']}

    uncategorized = stuff.xpath('//a[@href]').map {|link| [link.text.strip, link["href"]]} - stuff.xpath('//dl/dl/dl//a[@href]').map {|link| [link.text.strip, link["href"]]}
    stuff_in_folders = stuff.xpath('//dl/dl/dl').map {|x| x.search('./dt//a[@href]').map {|link| [link.text.strip, link["href"]]}}
    folder_headings = stuff.xpath('//h3').map {|thing| thing.text}[1..-1]
    return false if uncategorized == [] && stuff_in_folders == []
    thumblist = self.create(uncategorized, stuff_in_folders, folder_headings, user)
    GetThumbnails.call(thumblist)
  end

  def self.create(uncategorized, stuff_in_folders, folder_headings, user)
    thumblist = []
    if uncategorized.length > 0
      if user.lists.where(name: "uncategorized").length > 0
        new_list = user.lists.where(name: "uncategorized").first
      else
        new_list = user.lists.create(name: "uncategorized")
      end
      uncategorized.each do |bookmark_info|
        if Bookmark.where(name: bookmark_info[0], url: bookmark_info[1]).length == 0
          new_bookmark = Bookmark.create(name: bookmark_info[0], url: bookmark_info[1])
          new_list.saved_bookmarks.create(bookmark_id: new_bookmark.id)
        else
          new_list.saved_bookmarks.create(bookmark_id: Bookmark.where(name: bookmark_info[0], url: bookmark_info[1]).first.id)
          new_bookmark = Bookmark.where(name: bookmark_info[0], url: bookmark_info[1]).first
        end
        thumblist << new_bookmark.id
      end
    end

    if stuff_in_folders.length > 0
      folder_headings.each_with_index do |heading, index|
        new_list = user.lists.create(name: heading)
        if stuff_in_folders[index].length > 0
          stuff_in_folders[index].each do |bookmark_info|
            if Bookmark.where(name: bookmark_info[0], url: bookmark_info[1]).length == 0
              new_bookmark = Bookmark.create(name: bookmark_info[0], url: bookmark_info[1])
              new_list.saved_bookmarks.create(bookmark_id: new_bookmark.id)
            else
              new_list.saved_bookmarks.create(bookmark_id: Bookmark.where(name: bookmark_info[0], url: bookmark_info[1]).first.id)
              new_bookmark = Bookmark.where(name: bookmark_info[0], url: bookmark_info[1]).first
            end
            thumblist << new_bookmark.id
          end
        end
      end
    end
    thumblist
  end

end
