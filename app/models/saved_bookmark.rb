class SavedBookmark < ActiveRecord::Base
  belongs_to :list
  belongs_to :bookmark

  validates :list_id, presence: true
  validates :bookmark_id, presence: true
end
