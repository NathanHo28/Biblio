class PagesController < ApplicationController
  def create

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
