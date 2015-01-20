class UserSessionsController < ApplicationController
  def new
  	if logged_in?
  		redirect_to feed_path
  	else
  		@user = User.new
      render :layout => false
    end
  end

# Flashes and notices dont work!
  def create
  	if @user = login(params[:email], params[:password], params[:remember_me])
  		redirect_back_or_to(root_url, notice: 'Login successful')
  	else
  		redirect_to :back, alert: "Oops the email or password you provided is incorrect!"
  	end
  end

  def destroy
  	logout
  	redirect_to root_url, notice: 'Logged out!'
  end
end