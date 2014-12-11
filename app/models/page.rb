class Page < ActiveRecord::Base
	has_one :owner, through: :story
	belongs_to :story
	mount_uploader :page_photo, PagePhotoUploader #this is the uploader i think

	# accepts_nested_attributes_for :image, :reject_if => :all_blank, :allow_destroy => true
end
