class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  before_filter :configure_permitted_parameters, if: :devise_controller?

  layout :layout_by_resource

  def set_headers
    # headers['Access-Control-Allow-Origin'] = 'http://140.113.72.8'
    headers['Access-Control-Allow-Origin'] = 'http://localhost'
    # headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE, PATCH, OPTIONS, HEAD'
    headers['Access-Control-Allow-Headers'] = '*, x-requested-with, Content-Type, Accept, If-Modified-Since, If-None-Match, X-CSRF-Token'
    headers['Access-Control-Allow-Credentials'] = 'true'
    # headers['Access-Control-Max-Age'] = '86400'
  end

  def is_admin?
    return session[:admin] != nil
  end



  protected

  def layout_by_resource
    if devise_controller?
      "user"
    else
      "application"
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:account, :first_name, :last_name, :country_code, :time_zone, :email, :password, :password_confirmation, :remember_me, :how_to_know, :receive_information) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :account, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:account, :email, :password, :password_confirmation, :current_password) }
  end

end
