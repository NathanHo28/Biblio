class Page < ActiveRecord::Base
	has_one :owner, through: :story
	belongs_to :story
end
