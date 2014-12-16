class RelationshipsController < ApplicationController
	before_action :require_login
	validates_uniqueness_of :followed_id

	def create
		user = User.find(params[:followed_id])
		current_user.follow(user)
		#point unfollow and follow links to create destroy 
		redirect_to user
	end

	def destroy
		user = Relationship.find(params[:id]).followed
		current_user.unfollow(user)
		redirect_to user
	end
end
