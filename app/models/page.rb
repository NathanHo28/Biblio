class Page < ActiveRecord::Base
	belongs_to :owner, through: :story
	belongs_to :story
end
