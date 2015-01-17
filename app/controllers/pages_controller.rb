class PagesController < ApplicationController

  before_filter :require_login, except: [:show]

  def create
    @page = Page.new(page_params)
    if @page.save
      redirect_to stories_url, notice: "page created successfully"
    else
      render 'new'
    end
  end

  def new
    @page = Page.new
  end

  def show
    @page = Page.find(params[:id])
  end

  def destroy
    @page = Page.find(params[:id])
    if @page.destroy
      redirect_to stories_url, notice: 'destroyed page successfully'
    end
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(page_params)
      redirect_to page_path(@page)
    end
  end

  private
    def page_params
      params.require(:page).permit(:page_photo, :caption, :story_id, :page_number)
    end

end