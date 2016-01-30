class Bookmark < ActiveRecord::Base
  has_many :saved_bookmarks, dependent: :destroy
  has_many :lists, through: :saved_bookmarks
  has_many :creators, through: :lists, class_name: "User"

  validates :name, presence: true
  validates :url, presence: true
end
