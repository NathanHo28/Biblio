class UserSessionsController < ApplicationController
  def new
  	if logged_in?
  		redirect_to stories_path
  	else
  		@user = User.new
  	end
  end

  def create
  	if @user = login(params[:email], params[:password])
  		redirect_back_or_to(:stories, notice: 'Login successful')
  	else
  		flash.now[:alert] = 'Login failed'
  		render action: 'new'
  	end
  end

  def destroy
  	logout
  	redirect_to(:stories, notice: 'Logged out!')
  end
end
