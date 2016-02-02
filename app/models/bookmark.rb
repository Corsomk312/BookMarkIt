require 'open-uri'

class Bookmark < ActiveRecord::Base

  has_many :saved_bookmarks, dependent: :destroy
  has_many :lists, through: :saved_bookmarks
  has_many :creators, through: :lists, class_name: "User"

  has_attached_file :snapshot, styles: {
  # thumb: '100x100>',
  # square: '200x200#',
  # medium: '300x300>'
  }

  validates :name, presence: true
  validates :url, presence: true

  validates_attachment_content_type :snapshot, :content_type => /\Aimage\/.*\Z/
  validate :has_valid_url

  def has_valid_url
    unless self.url.start_with?("http")
      self.errors[:url] = "Url must be valid"
    end
  end

end
