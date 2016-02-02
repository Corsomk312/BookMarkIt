class User < ActiveRecord::Base
  has_many :lists, foreign_key: :creator_id
  has_many :saved_bookmarks, through: :lists
  has_many :bookmarks, through: :saved_bookmarks
  has_one  :upload

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :auth_token, uniqueness: true

  has_secure_password
  before_save :set_auth_token

  def full_name
    return self.username if self.first_name == nil || self.last_name == nil
    return self.username if self.first_name == "" && self.last_name == ""
    "#{self.first_name.capitalize} #{self.last_name.capitalize}"
  end

  def lists_by_age
    self.lists.sort_by {|list| list.created_at}
  end

  def lists_by_name
    self.lists.sort_by {|list| list.name.downcase}
  end

  def lists_by_popularity
    self.lists.sort_by {|list| List.where(name: list.name).count}
  end

  def lists_by_size
    self.lists.sort_by {|list| list.bookmarks.length}
  end

  private

  def set_auth_token
    return if auth_token.present?
    self.auth_token = generate_auth_token
  end

  def generate_auth_token
    SecureRandom.uuid.gsub(/\-/,'')
  end
end
