class User < ActiveRecord::Base
  has_many :lists, foreign_key: :creator_id
  has_many :saved_bookmarks, through: :lists
  has_many :bookmarks, through: :saved_bookmarks
  has_one  :upload
  has_many :active_relationships, class_name:  "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name:  "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships

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

  # def get_info
  #   bookmarks = self.bookmarks.count
  #   followers = self.followers.count

  #   if bookmarks == 1
  #     followers == 1 ? "#{bookmarks} bookmark | #{followers} follower" : "#{bookmarks} bookmark | #{followers} followers"
  #   else
  #     followers == 1 ? "#{bookmarks} bookmarks | #{followers} follower" : "#{bookmarks} bookmarks | #{followers} followers"
  #   end
  # end

  def bookmarks_label
    self.bookmarks.count == 1 ? "bookmark" : "bookmarks"
  end

  def followers_label
    self.followers.count == 1 ? "follower" : "followers"
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

  # Follows a User
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # Unfollows a user
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # Returns true if the current user is following the other user
  def following?(other_user)
    following.include?(other_user)
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
