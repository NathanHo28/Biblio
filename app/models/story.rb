class Story < ActiveRecord::Base
	has_many :pages
	has_many :pins
	has_many :pinned_bys, through: :pins, source: :user
	belongs_to :owner, class_name: 'User'

	accepts_nested_attributes_for :pages, :reject_if => :all_blank, :allow_destroy => true
	acts_as_taggable_on :tags
	acts_as_votable

	def score
		self.get_upvotes.size
	end
end
