class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  
  protect_from_forgery with: :exception
  add_flash_types :success, :warning, :danger, :info

  before_filter :authenticate_user!, if: :check_devise
  
  def after_sign_in_path_for(resource)
    root_path
  end

  def check_devise
  	if  not /devise/.match(params[:controller]) or not current_user.nil?
  		return true
  	else
  		false
  	end
  end
end
