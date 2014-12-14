class PasswordResetsController < ApplicationController
  skip_before_filter :require_login

  #user submits password reset input and gets redirected here
  def create
  	@user = User.find_by_email(params[:email])

  	#email user on how to reset password
  	@user.deliver_reset_password_instructions! if @user 

  	#email sent if it exists in database or not
  	#this discloses no personal information to unwanted eyes
  	redirect_to(root_path, :notice => 'Please check your email and follow the given directions')
  end

  def edit
  	@token = params[:id]
  	@user = User.load_from_reset_password_token(params[:id])

  	if @user.blank?
	  	not_authenticated
	  	return
  	end
  end

  def update
  	@token = params[:id]
  	@user = User.load_from_reset_password_token(params[:id])

  	if @user.blank?
  	  not_authenticated
  	  return
  	end

  	#validates password
  	@user.password_confirmation = params[:user][:password_confirmation]

  	if @user.change_password!(params[:user][:password])
  		redirect_to(root_path, :notice => 'Password has been reset!')
  	else
  		render :action => 'edit'
  	end
  end
end
