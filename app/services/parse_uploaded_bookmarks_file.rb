include CurrentUserHelper # can probably remove this module, as it doesn't work in Services

class ParseUploadedBookmarksFile

  # def self.call(file, user)
  #   books = Nokogiri::HTML(file)
  #   urls = books.css("a").map { |link| link['href']}
  #   titles = books.css("a").map { |link| link.text }
  #   zipped = titles.zip(urls).flatten.compact
  #   zipped2d = zipped.each_slice(2).to_a
  #   persist_uploaded_bookmarks(zipped2d, user)
  #   parse(urls)
  # end

  def self.call(file, user)
    stuff = Nokogiri::HTML(file)
    uncategorized = stuff.xpath('//a[@href]').map {|link| [link.text.strip, link["href"]]} - stuff.xpath('//dl/dl/dl//a[@href]').map {|link| [link.text.strip, link["href"]]}
    stuff_in_folders = stuff.xpath('//dl/dl/dl').map {|x| x.search('./dt//a[@href]').map {|link| [link.text.strip, link["href"]]}}
    folder_headings = stuff.xpath('//h3').map {|thing| thing.text}[1..-1]
    self.create(uncategorized, stuff_in_folders, folder_headings, user)
    # p uncategorized
    # p stuff_in_folders
    # p folder_headings
  end

  def self.create(uncategorized, stuff_in_folders, folder_headings, user)

    if uncategorized.length > 0
      new_list = user.lists.create(name: "uncategorized")
      uncategorized.each do |bookmark_info|
        if Bookmark.where(name: bookmark_info[0], url: bookmark_info[1]).length == 0
          new_bookmark = Bookmark.create(name: bookmark_info[0], url: bookmark_info[1])
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
              new_bookmark = Bookmark.create(name: bookmark_info[0], url: bookmark_info[1])
              new_list.saved_bookmarks.create(bookmark_id: new_bookmark.id)
            else
              new_list.saved_bookmarks.create(bookmark_id: Bookmark.where(name: bookmark_info[0], url: bookmark_info[1]).first.id)
            end
          end
        end
      end
    end

  end

  # def self.persist_uploaded_bookmarks(zipped2d, user)
  #   user_first_name = user.first_name.capitalize + "'s Bookmarks"
  #   list = user.lists.create!(name: user_first_name)
  #   zipped2d.each do |subarray|
  #     new_bookmark = list.bookmarks.create!(name: subarray[0], url: subarray[1])
  #     # Bookmark.create(name: subarray[0], url: subarray[1])  ### Must link with UserID
  #   end
  # end


  def self.parse(urls)
    urls.each do |url|
      ParseURI.call(url);
    end
  end


end
