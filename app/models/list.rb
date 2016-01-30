class List < ActiveRecord::Base
  has_many :saved_bookmarks, dependent: :destroy
  has_many :bookmarks, through: :saved_bookmarks
  belongs_to :creator, class_name: "User"

  validates :creator_id, presence: true
  validates :name, presence: true
end
