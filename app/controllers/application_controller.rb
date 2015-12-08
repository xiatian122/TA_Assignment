class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  include CanCan::ControllerAdditions

  rescue_from CanCan::AccessDenied do |exception|

  	flash[:danger] = exception.message
    redirect_to main_app.error_url

  end
end
