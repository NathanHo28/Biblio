class StoriesController < ApplicationController
  # before_filter :require_login, except: [:index, :show]

  def index
    @stories = if params[:story]
      search
    elsif logged_in? && current_user.following.any?
      feed_items
    else
      Story.order('stories.created_at DESC')
    end.page(params[:page])
  end

  def feed_items
    @stories = Story.all
    Kaminari.paginate_array(current_user.feed)
  end

  def search
    #call private method below
    story_params
    #if field is blank(whitespace or empty) this strips it from the search params
    sanity_check = story_params.delete_if {|category, value| value.blank?}
    inquiry = Story.all
    #sanity_check represents search filters now

    sanity_check.each do |key, column|

      case key
      when "title"
        inquiry = inquiry.where(["#{key} iLIKE ?", "%#{column}%"])


      when "tag_list"
        #did not put % around column as tags must match exactly
        inquiry = inquiry.tagged_with("#{column}", :any => true)

      when "created_at"
        if column == "Oldest"
          inquiry = inquiry.order('stories.created_at')
        else
          inquiry = inquiry.order('stories.created_at DESC')
        end

      when "cached_votes_score"
        inquiry = inquiry.order('stories.cached_votes_score DESC')
      end
    end

    inquiry
  end

  def new
    @story = Story.new
  end

  def create
    @story = Story.new(story_params)
    @story.owner = current_user
    if @story.save
      redirect_to stories_path, notice: "story created successfully"
    else
      render :new
    end
  end

  def upvote
    @story = Story.find(params[:id])
    @story.upvote_by current_user
    respond_to do |format|
      format.html
      format.js
    end
  end

  def tagged
    if params[:tag].present?
      @stories = Story.tagged_with(params[:tag])
    else
      @stories = Story.all
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
      redirect_to stories_path(@story), notice: "story has been updated"
    else
      render :edit
    end
  end

  def destroy
    @story = Story.find(params[:id])
    @story.destroy
    redirect_to stories_path, notice: "story has been removed"
  end

  private
  def story_params
    params.require(:story).permit(:title, :cached_votes_score, :tag_list, :created_at, :latitude, :longitude, :city,  pages_attributes: [:id, :page_photo, :caption, :page_number, :story_id])
  end
end
