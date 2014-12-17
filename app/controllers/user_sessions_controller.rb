class UserSessionsController < ApplicationController
  def new
  	if logged_in?
  		redirect_to feed_path
  	else
  		@user = User.new
  	end
  end

# Flashes and notices dont work!
  def create
  	if @user = login(params[:email], params[:password], params[:remember_me])
  		redirect_back_or_to(root_url, notice: 'Login successful')
  	else
  		flash.now[:alert] = 'Login failed'
  		render action: 'new'
  	end
  end

  def destroy
  	logout
  	redirect_to root_url, notice: 'Logged out!'
  end
end
