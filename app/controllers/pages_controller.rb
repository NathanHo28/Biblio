class PagesController < ApplicationController

  def create
    @page = Page.new(page_params)
    if @page.save
      redirect_to story_url, notice "page created successfully"
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
    
  end

  def edit
  end

  def update
  end
end
