class User < ActiveRecord::Base
  authenticates_with_sorcery!
  acts_as_voter

  has_many :pages, through: :own_stories
  has_many :own_stories, class_name: 'Story', foreign_key: 'owner_id'
  has_many :other_stories, through: :following, source: :own_stories # use this relation to create the feed structure

  has_many :contributions
  has_many :contributed_stories, class_name: "Story", through: :story_contributors

  geocoded_by :address   # can also be an IP address
  after_validation :geocode

  has_many :relationships, foreign_key: :follower_id, dependent: :destroy
  has_many :following, through: :relationships, source: :followed, class_name: "User" #1



  has_many :pins
  has_many :pinned_stories, through: :pins
  
  def followers
    Relationship.where(followed: self).includes(:follower).map(&:follower)
  end

  def address
    [home_town, country].compact.join(', ')
    #.compact removes all nil values, very cool
  end

  validates :password, length: {minimum: 3}
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :email, uniqueness: true

  mount_uploader :photo, PhotoUploader

  def feed
    following.map{|user| user.own_stories}.flatten
  end

  def follow(other_user)
  	relationships.create(followed_id: other_user) #took out active of both follow and unfollow
  end

  def unfollow(other_user)
  	relationships.find_by(followed_id: other_user).destroy
  end

  #returns true if current user is following other user
  def following?(other_user)
  	following.include?(other_user)
  end
end
