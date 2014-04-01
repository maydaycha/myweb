class FacebookController < ApplicationController
  def index
  end

  def create
    auth_hash = request.env['omniauth.auth']
    if auth_hash
      uid = auth_hash['uid'].to_s
      authUser = Facebook.where(uid:uid).first
      if authUser
        puts "new token"
      else
        Facebook.create do |c|
          c.uid = uid
        end
      end
      session[:uid] = uid
    else
      render :json => { :status => "fail", :reason => "cant access your info" }
    end
    render :json => { :status => "success", :user_info => auth_hash }
  end

  def failure
    flash[:notice] = '您尚未經過認證'
    redirect_to :controller=>:signup,:action=>:index
  end


end
