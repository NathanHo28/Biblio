class Story < ActiveRecord::Base
	has_many :pages
	has_many :pins
	has_many :pinned_bys, through: :pins, source: :user
	belongs_to :owner, class_name: 'User'

	geocoded_by :address   # can also be an IP address
	after_validation :geocode          # auto-fetch coordinates

	#not sure we need these
	reverse_geocoded_by :latitude, :longitude
	after_validation :reverse_geocode

	accepts_nested_attributes_for :pages, :reject_if => :all_blank, :allow_destroy => true
	acts_as_taggable_on :tags
	acts_as_votable

	# validate :page_limit

	def address


	def score
		self.get_upvotes.size
	end

	# def page_limit
	# 	@story.pages.page_number = @story.pages.length
	# 	if :page_number > 20
	# 		redirect_to :back, notice: "Too many pages!"
	# 	end	
	# end
end