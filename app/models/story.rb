class Story < ActiveRecord::Base
	has_many :pages
	has_many :pins
	has_many :pinned_bys, through: :pins, source: :user
	belongs_to :owner, class_name: 'User'

	accepts_nested_attributes_for :pages, :reject_if => :all_blank, :allow_destroy => true
	acts_as_taggable_on :tags
	acts_as_votable

	validate :page_limit

	def score
		self.get_upvotes.size
	end

	def page_limit
		@story.pages.page_number = @story.pages.length
		if :page_number > 20
			redirect_to :back, notice: "Too many pages!"
		end	
	end
end