class Users::RegistrationsController < Devise::RegistrationsController
  # layout 'user'

  def create
    first_name = params[:first_name]
    last_name = params[:last_name]
    if valid_captcha?(params[:captcha])
      super
      if not @user.new_record?
        session[:omniauth] = nil
        @user.user_authentications.create!(:provider => session["devise:provider"],
                                           :uid => session['devise:uid'],
                                           :token => session["devise:token"],
                                           :token_secret => "") if session["devise:provider"] != nil
        @user.update!(current_role: nil)
      end

      if not @user.new_record?
        if params[:from] == "employer_personal"
          @user.user_employer_personals.create!(:first_name => params[:user][:first_name],
                                               :last_name => params[:user][:last_name])
          @user.update!(current_role: "p#{@user.user_employer_personals.last.id}")
        elsif params[:from] == "employer_company"
          @user.user_employer_companies.create!(:first_name => params[:user][:first_name],
                                               :last_name => params[:user][:last_name],
                                               :company_name => params[:company_name])
          @user.update!(current_role: "c#{@user.user_employer_companies.last.id}")
        end
      end
    else
      build_resource(sign_up_params)
      clean_up_passwords(resource)
      flash.now[:alert] =  I18n.t("error.recaptcha")
      flash.delete :recaptcha_error

      if params[:from] == "employer_personal"
        @from = "employer_personal"
        render :employer_new
      elsif params[:from] == "employer_company"
        @from = "employer_company"
        render :employer_new
      else
        render :new
      end
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
      if params[:from] == 'company'
        redirect_to users_employer_company_profile_path(params[:company_id])
      elsif params[:from] == 'personal'
        redirect_to users_employer_personal_profile_path(params[:personal_id])
      else
        redirect_to users_profile_path(resource)
      end
    else
      clean_up_passwords resource
      flash[:alert] = resource.errors.full_messages.map { |msg| "#{msg}\n" }.join
      flash[:alert].sub! 'Current password', t('error.oldpassword')
      if params[:from] == 'company'
        redirect_to users_employer_company_profile_path(params[:company_id])
      elsif params[:from] == 'personal'
        redirect_to users_employer_personal_profile_path(params[:personal_id])
      else
        redirect_to users_profile_path(resource)
      end
    end
  end

  def verify_email
    @email = params[:email]
    @user = User.find_by_email(params[:email])
    render template: "users/registrations/verify_email"
  end

  def verify_success

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

  def employer_new
    build_resource()
  end

  def employer_new_social
    build_resource({
      first_name: session["devise:info"]["first_name"],
      last_name: session["devise:info"]["last_name"],
      email: session["devise:info"]["email"],
      picture: session["devise:info"]["image"],
      })
  end

end
