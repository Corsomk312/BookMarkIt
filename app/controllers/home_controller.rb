class HomeController < ApplicationController

  def index
  	bookmarks = Bookmark.first(200)
		@y = 1
		@x = 1
		table = bookmarks.map.with_index do |val, index|
			# puts index
			if index % 9 == 0
				@y += 1
				@x = 1
			end
			@x += 1
		  p "#{val.name}", "#{val.url}", " ", "#{@x}", "#{@y}"
		end
		@table = table.flatten
  end
end
