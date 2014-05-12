class Users::RegistrationsController < Devise::RegistrationsController
  # layout 'user'

  def create
    if verify_recaptcha
      super
      if not @user.new_record?
        session[:omniauth] = nil
        @user.user_authentications.create!(:provider => session["devise:provider"], :uid => session['devise:uid'], :token => session["devise:token"], :token_secret => "") if session["devise:provider"] != nil
      end
    else
      build_resource(sign_up_params)
      clean_up_passwords(resource)
      flash.now[:alert] =  I18n.t("error.recaptcha")
      flash.delete :recaptcha_error
      render :new
    end
  end

  def verify_email
    print "======="
    print params.to_json
    print "======="
    @email = params[:email]
    @user = User.find_by_email(params[:email])
    render template: "users/registrations/verify_email"
  end

  def after_inactive_sign_up_path_for(user)
    verify_user_registration_path(email: user.email)
  end

  def build_resource(*args)
    super
    # if session[:omniauth]
    #   @user.apply_omniauth(session[:omniauth])
    #   @user.valid?
    # end
  end

  def new
    if params[:username] && params[:email]
      if not params[:username] =~ /\w/
        flash[:warning] = "username only accept english character and digital"
        redirect_to "/"
      else
        build_resource({
         username: params[:username],
         email: params[:email]
         })
      end
    else
      super
    end
  end

  def new2
    build_resource({
     first_name: session["devise:info"]["first_name"],
     last_name: session["devise:info"]["last_name"],
     email: session["devise:info"]["email"],
     picture: session["devise:info"]["image"],
     })
    render template: "users/registrations/new2"
  end

end
