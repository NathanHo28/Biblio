class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def ensure_logged_in
  	unless current_user
  		flash[:alert] = "You need to log in!"
  		redirect_to new_session_path
  	end
  end
end