class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :pages, through: :own_stories
  has_many :own_stories, class_name: 'Story', foreign_key: 'owner_id'
  has_many :pins
  has_many :pinned_stories, through: :pins

  validates :password, length: {minimum: 3}
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :email, uniqueness: true
end
