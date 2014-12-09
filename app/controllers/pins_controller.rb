class PinsController < ApplicationController
  before_filter require_login, except: [:show]
  before_filter :load_story

  def create
  	@pin = @stories.pins.build(pin_params)
  	@pin.user_id = current_user.id
  end

  def destroy
  	@pin = Pin.find(params[:id])
  	@pin.destroy
  end

  def show
  	@pin = Pin.find(params[:id])
  end

  private
  def pin_params
  	params.require(:pin).permit(:story_id, :user_id)
  end

  def load_story
  	@story = Story.find(params[:story_id])
  end
end
