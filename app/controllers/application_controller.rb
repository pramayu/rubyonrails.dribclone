class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
  	devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :name, :password, :password_confirmation, :current_password, :profile) }
  	devise_parameter_sanitizer.for(:account_update) { |n| n.permit(:email, :name, :password, :password_confirmation, :current_password, :profile, :location, :website, :bio, :twitter, :facebook, :github, :instagram, :cm) }
  end
end
