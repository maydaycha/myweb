class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

  def set_headers
    # headers['Access-Control-Allow-Origin'] = 'http://140.113.72.8'
    headers['Access-Control-Allow-Origin'] = 'http://localhost'
    # headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE, PATCH, OPTIONS, HEAD'
    headers['Access-Control-Allow-Headers'] = '*, x-requested-with, Content-Type, Accept, If-Modified-Since, If-None-Match, X-CSRF-Token'
    headers['Access-Control-Allow-Credentials'] = 'true'
    # headers['Access-Control-Max-Age'] = '86400'
  end

end
