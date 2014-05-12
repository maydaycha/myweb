class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  before_action :protect

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
    puts "|#{I18n.locale}|"
    if I18n.locale == 'zh-tw' or I18n.locale == 'zh-Tw' or I18n.locale == 'zh-tW'
      I18n.locale = 'zh-TW'
    end

    # I18n.locale = 'zh-TW'
    logger.info "* Locale set to '#{I18n.locale}'"
    # print "* Locale set to '#{I18n.locale}'"
  end


  def after_sign_in_path_for(user)
    if current_user.step == 1
      edit_users_profile_path(user)
    elsif current_user.step == 2
      root_path
    else
      new_users_skill_category_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
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

  def protect
    @ips = ['125.227.181.61', '140.113.73.55', '127.0.0.1', '140.113.73.40', '140.113.73.30', '140.113.73.50', '140.113.72.8', '118.166.80.56', '36.226.230.98', '118.163.48.186', '111.253.21.3']
    if not @ips.include? request.remote_ip
      # Check for your subnet stuff here, for example
      # if not request.remote_ip.include?('127.0,0')
      render :text => "You are unauthorized"
      return
    end
  end

end
