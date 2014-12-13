class User < ActiveRecord::Base
  authenticates_with_sorcery!
  acts_as_voter

  has_many :pages, through: :own_stories
  has_many :own_stories, class_name: 'Story', foreign_key: 'owner_id'
  has_many :pins
  has_many :pinned_stories, through: :pins

  has_many :active_relationships, class_name: "Relationship",
  								  foreign_key: "follower_id", #user following another user identified with different foreign key
  								  dependent: :destroy #destroying a user should also destroy a relationship
  has_many :passive_relationships, class_name: "Relationship", #passive relation because possibility of not following back
  								   foreign_key: "followed_id",
  								   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed #explicitly tells rails that the source of the following arrays is the set of followed ids
  has_many :followers, through: :passive_relationships, source: :follower #source not needed but helps to illustrate structure
  validates :password, length: {minimum: 3}
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :email, uniqueness: true
  mount_uploader :photo, PhotoUploader

  # def feed
  # end

  #fat model skinny controller
  #i expect we need to define other_user?
  def follow(other_user)
  	active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
  	active_relationships.find_by(followed_id: other_user.id).destroy
  end

  #returns true if current user is following other user
  def following?(other_user)
  	following.include?(other_user)
  end
end
