class ThirdPartyLoginController < ApplicationController

  def create
    puts params[:provider]
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


  def google_create
    auth_hash = request.env['omniauth.auth']
    puts auth_hash
    # session[:user_id] = user.id
    # redirect_to root_path
    render :json => auth_hash.as_json
  end


  def failure
    flash[:notice] = '您尚未經過認證'
    redirect_to :controller => :signup, :action => :index
  end


end
