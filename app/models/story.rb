class Story < ActiveRecord::Base
	has_many :pages
	has_many :pins
	has_many :pinned_bys, through: :pins, source: :user
	belongs_to :owner, class_name: 'User'
	mount_uploader :page_photo, PagePhotoUploader #this is the uploader i think
end
