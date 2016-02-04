class List < ActiveRecord::Base
  has_many :saved_bookmarks, dependent: :destroy
  has_many :bookmarks, through: :saved_bookmarks
  belongs_to :creator, class_name: "User"

  validates :creator_id, presence: true
  validates :name, presence: true

  def total_bookmarks
    self.saved_bookmarks.count
  end

  def bookmarks_by_name
    self.bookmarks.sort_by {|bookmark| bookmark.name.downcase}
  end

  def bookmarks_by_age
    self.bookmarks.sort_by {|bookmark| bookmark.created_at}
  end

  def bookmarks_by_length
    self.bookmarks.sort_by {|bookmark| bookmark.url.length}
  end

  def bookmarks_by_popularity
    self.bookmarks.sort_by {|bookmark| SavedBookmark.where(bookmark_id: bookmark.id).count}
  end

end
