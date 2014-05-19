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

  # PUT /resource
  # We need to use a copy of the resource because we don't want to change
  # the current user in place.
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        puts flash_key
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, bypass: true
      flash[:alert] = resource.errors.full_messages.map { |msg| "#{msg}" }.join
      flash[:alert].sub! 'Current password', t('error.oldpassword')
      redirect_to users_profile_path(resource)
    else
      clean_up_passwords resource
      flash[:alert] = resource.errors.full_messages.map { |msg| "#{msg}\n" }.join
      flash[:alert].sub! 'Current password', t('error.oldpassword')
      redirect_to users_profile_path(resource)
    end
  end

  def verify_email
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
        flash[:alert] = t("error.username_format")
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
