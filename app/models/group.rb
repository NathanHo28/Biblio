class Group < ActiveRecord::Base
	belongs_to :owner, class_name: "Group"
	belongs_to :story, class_name: "Story", foreign_key: ':story_id'

	has_many :users, class_name: "User", foreign_key: ':user_id'

	enum state: { limited: 0, full: 1, special: 2 }
	#this allows for multiple authority levels on what a user will be able to do
	#state names cannot be the same as model methods. i will either be defining 
	#member, owner, and sponsored in controller or model so, to be safe, I will
	#use state names that reflect authority level 
end
