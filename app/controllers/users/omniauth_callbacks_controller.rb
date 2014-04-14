class Users::OmniauthCallbacksController < ApplicationController
  def index
    @user_authentications = current_user.authentications.all
  end

  def facebook
    omni = request.env["omniauth.auth"]

    user_authentication = UserAuthentication.find_by_provider_and_uid(omni['provider'], omni['uid'])

    if user_authentication
      flash[:notice] = "Logged in Successfully"
      sign_in_and_redirect User.find(user_authentication.user_id)
    elsif current_user
      token = omni['credentials'].token
      token_secret = ""

      current_user.user_authentications.create!(:provider => omni['provider'], :uid => omni['uid'], :token => token, :token_secret => token_secret)

      flash[:notice] = "Authentication successful."
      sign_in_and_redirect current_user
    else
      session["devise:provider"] = request.env["omniauth.auth"]["provider"]
      session["devise:uid"] = request.env["omniauth.auth"]["uid"]
      session["devise:info"] = request.env["omniauth.auth"]["info"]
      session["devise:token"] = request.env["omniauth.auth"]["credentials"]["token"]
      redirect_to new2_user_registration_path


      # user = User.new
      # user.first_name = omni['extra']['raw_info'].first_name
      # user.last_name = omni['extra']['raw_info'].last_name
      # user.email = omni['extra']['raw_info'].email
      # user.picture = omni['extra']['raw_info'].image

      # user.apply_omniauth(omni)

      # if user.save
      #   flash[:notice] = "Logged in."
      #   sign_in_and_redirect User.find(user.id)
      # else
      #   session[:omniauth] = omni
      #   redirect_to new_user_registration_path
      # end
    end
  end

  def google_oauth2
    return render :json => { content: request.env["omniauth.auth"] }
  end
end
