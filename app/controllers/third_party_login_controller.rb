class ThirdPartyLoginController < ApplicationController

  def facebook_create
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
    user_info = auth_hash['info']
    message = User.signup_with_social(user_info['first_name'], user_info['last_name'], user_info['email'])
    puts message
    puts message['status']
    puts message['message']
    if message['status'] != 'success'
      render :json => message
    else
      render :json => { :status => "success", :user_info => auth_hash }
    end
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
