class Upload < ActiveRecord::Base
  validates :user_id, presence: true
  validates :client_file, presence: true

  belongs_to :user

  has_attached_file :client_file

end
