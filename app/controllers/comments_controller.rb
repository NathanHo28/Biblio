class CommentsController < ApplicationController
	before_filter :load_story

  def show
  	@comment = Comment.find(params[:id])
  end

  def create
  	@comment = @story.comments.build(comment_params)
  	@comment.user = current_user
  	if @comment.save
  		redirect_to stories_path, notice: 'comment posted'
  	else
  		render 'stories/show'
  	end
  end

  def destroy
  	@comment = Comment.find(params[:id])
  	@comment.destroy
  end

	private
	def comment_params
		params.require(:comment).permit(:passage, :story_id)
	end

	def load_story
		@story = Story.find(params[:story_id])
	end
end
