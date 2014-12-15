class RelationshipsController < ApplicationController
	before_action :require_login
	validates_uniqueness_of :follower_id, :followed_id

	def create
		user = User.find(params[:followed_id])
		current_user.follow(user)
		# validates_uniqueness_of :user_id, :scope => [:follower_id, :followed_id]
		redirect_to user
	end

	def destroy
		user = Relationship.find(params[:id]).followed
		current_user.unfollow(user)
		# validates_uniqueness_of :user_id, :scope => [:follower_id, :followed_id]
		redirect_to user
	end
end
