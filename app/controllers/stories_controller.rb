class StoriesController < ApplicationController
  # before_filter :require_login, except: [:index, :show]

  def index
    @stories = if params[:story_fields]
      results = search
    else
      Story.order('stories.created_at DESC')
    end.page(params[:page])

    # @stories = if params[:search]
    #   results = (Story.where("LOWER(title) LIKE LOWER(?)", "%#{params[:search]}%") +
    #              Story.tagged_with(params[:search], :any => true)).uniq
    #   Kaminari.paginate_array(results)
    #   # page cannot ordinarily be called on arrays so need to call special paginate method
    # else
    #   Story.order('stories.created_at DESC')
    # end.page(params[:page])

    # respond_to do |format|
    #   format.html
    #   format.js
    # end
  end

  def search
    search_params
    sanity_check = search_params.delete_if {|category, value| value.blank?}
    inquiry = Story.all 
    sanity_check.each do |key, column|

      if key == "title"
        inquiry = inquiry.where(["#{key} iLIKE ?", "%#{column}%"])
      end

      if key == "tag_list"
        inquiry = inquiry.tagged_with("#{column}", :any => true)
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
    params.require(:story).permit(:title, :tag_list, pages_attributes: [:page_photo, :caption, :page_number, :story_id])
  end

  def search_params
    params.require(:story_fields).permit(:title, :tag_list)
  end
end
