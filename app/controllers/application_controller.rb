class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  # layout :layout_by_resource
  layout false


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


  def set_locale
    logger.info "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
    I18n.locale = extract_locale_from_accept_language_header
    # I18n.locale = 'es'
    logger.info "* Locale set to '#{I18n.locale}'"
  end


  def after_sign_in_path_for(user)
    new_users_skill_category_path
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
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :first_name, :last_name, :country_code, :time_zone, :email, :password, :password_confirmation, :remember_me, :how_to_know, :receive_information, :token, :picture) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end

  private

  def extract_locale_from_accept_language_header
    # request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    request.env['HTTP_ACCEPT_LANGUAGE'].split(/,/)[0]
  end

end
