class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		redirect_to stories_url, notice: 'Yay!'
  	else
  		render 'new'
  	end
  end

  def show
  	@user = User.find(params[:id])
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.all
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.all
    render 'show_follow'
  end

  # rails will implicitly render the template corresponding
  # to an action, but action following and followers will make
  # an EXPLICIT call to render the show_follow

  def destroy
  	@user = User.find(params[:id])
  	if @user.destroy
  		redirect_to stories_url, notice: ':(((((((((((('
  	else
  		render root_url
  	end
  end

  private
  def user_params
  	params.require(:user).permit(:first_name, :last_name, :username, :email, :photo, :about_me, :home_town, :password, :password_confirmation)
  end
end
