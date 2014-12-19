class User < ActiveRecord::Base
  authenticates_with_sorcery!
  acts_as_voter

  has_many :pages, through: :own_stories
  has_many :own_stories, class_name: 'Story', foreign_key: 'owner_id'
  has_many :other_stories, through: :following, source: :own_stories # use this relation to create the feed structure
  has_many :pins
  has_many :pinned_stories, through: :pins

  #geocoder shit here
  geocoded_by :address   # can also be an IP address
  after_validation :geocode
  # has_many :active_relationships, class_name: "Relationship",
  # 								  foreign_key: "follower_id", #user following another user identified with different foreign key
  # 								  dependent: :destroy #destroying a user should also destroy a relationship

  # has_many :passive_relationships, class_name: "Relationship", #passive relation because possibility of not following back
  # 								   foreign_key: "followed_id",
  # 								   dependent: :destroy

  has_many :relationships, foreign_key: :follower_id, dependent: :destroy
  has_many :following, through: :relationships, source: :followed, class_name: "User" #1

  def followers
    Relationship.where(followed: self).includes(:follower).map(&:follower)
  end

  def address
    [home_town, country].compact.join(', ')
    #.compact removes all nil values, very cool
  end

  # instead of active and passive relationships there is just relationships
  # since you can only establish a relationship by following someone
  # to get "following" it goes through relationships and gets the id of when the user followed(*) someone (created the relationship)
  # (*) see how followed: [is set to] self
  # in the console m.following.count returns 12
  #                m.following.first returns m's first person they are following
  #                m.followers returns false [m doesnt have any]

  # 1 has_many :following, through: :active_relationships, source: :followed #explicitly tells rails that the source of the following arrays is the set of followed ids
  # has_many :followers, through: :passive_relationships, source: :follower #source not needed but helps to illustrate structure

  validates :password, length: {minimum: 3}
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :email, uniqueness: true

  mount_uploader :photo, PhotoUploader

  def feed
    following.map{|user| user.own_stories}.flatten
  end

  # [16] pry(main)> m.following.map do |user|
  # [16] pry(main)*   user.own_stories
  # [16] pry(main)* end

  #fat model skinny controller
  #i expect we need to define other_user?

  # def destroy(other_user)
  #   @relationship = user_id.followed_id.find(params[:id])
  #   @relationship.destroy
  #   flash[:notice] = "unfollowed"
  #   redirect_to current_user
  #   # active_relationships(followed_id: other_user)
  # end

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
