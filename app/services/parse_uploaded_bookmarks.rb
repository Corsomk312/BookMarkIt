include CurrentUserHelper

class ParseUploadedBookmarks

  def self.call(file, user)
    books = Nokogiri::HTML(file)
    urls = books.css("a").map { |link| link['href']}
    titles = books.css("a").map { |link| link.text }
    zipped = titles.zip(urls).flatten.compact
    zipped2d = zipped.each_slice(2).to_a
    persist_uploaded_bookmarks(zipped2d, user)
    parse(urls)
  end

  def self.persist_uploaded_bookmarks(zipped2d, user)
    user_first_name = user.first_name.capitalize + "'s Bookmarks"
    list = user.lists.create!(name: user_first_name)
    zipped2d.each do |subarray|
      new_bookmark = list.bookmarks.create!(name: subarray[0], url: subarray[1])
      # Bookmark.create(name: subarray[0], url: subarray[1])  ### Must link with UserID
    end
  end


  def self.parse(urls)
    urls.each do |url|
      ParseURI.call(url);
    end
  end


end
