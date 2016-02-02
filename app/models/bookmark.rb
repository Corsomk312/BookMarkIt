require 'open-uri'

class Bookmark < ActiveRecord::Base

  has_many :saved_bookmarks, dependent: :destroy
  has_many :lists, through: :saved_bookmarks
  has_many :creators, through: :lists, class_name: "User"
  has_one :snapshot

  validates :name, presence: true
  validates :url, presence: true

  validate :has_valid_url

  def has_valid_url
    unless self.url.start_with?("http")
      self.errors[:url] = "Url must be valid"
    end
  end

end
