class Snapshot < ActiveRecord::Base
  belongs_to :bookmark

  has_attached_file :thumbnail, styles: {
    # thumb: '100x100>',
    # square: '200x200#',
    # medium: '300x300>'
  }

  validates_attachment_content_type :thumbnail, :content_type => /\Aimage\/.*\Z/

end
