class Group < ActiveRecord::Base
	belongs_to :owner, class_name "Group"
	belongs_to :story, class_name "Story", foreign_key: :story_id

	has_many :users, class_name "User", foreign_key: :user_id
end
