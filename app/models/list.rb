class List < ActiveRecord::Base
  has_many :saved_bookmarks, dependent: :destroy
  has_many :bookmarks, through: :saved_bookmarks
  belongs_to :creator, class_name: "User"

  validates :creator_id, presence: true
  validates :name, presence: true

  def bookmarks_by_name
    self.bookmarks.sort_by {|bookmark| bookmark.name}
  end

  def bookmarks_by_creation_date
    self.bookmarks.sort_by {|bookmark| bookmark.created_at}
  end

  def bookmarks_by_url_lengthg
    self.bookmarks.sort_by {|bookmark| bookmark.url.length}
  end

end
