class StoriesController < ApplicationController
  before_filter :ensure_logged_in, only: [:show]

  def index
    @stories = Story.order('stories.created_at DESC').page(params[:page])
  end

  def new
    @story = Story.new
  end

  def create
    @story = Story.new(story_params)
    if @story.save
      redirect_to stories_path
    else
      render :new
    end
  end

  def show
    @story = Story.find(params[:id])
  end

  def edit
    @story = Story.find(params[:id])
  end

  def update
    @story = Story.find(params[:id])
    if @story.update_attributes(story_params)
      redirect_to stories_path(@story)
    else
      render :edit
    end
  end

  def destroy
    @story = Story.find(params[:id])
    if @story.destroy
      redirect_to stories_path
    else
      render :show #??
    end
  end

  private
  def story_params
    params.require(:story).permit(:title, :owner_id)
  end
end
