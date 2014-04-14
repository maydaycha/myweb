class Users::RegistrationsController < Devise::RegistrationsController
  layout 'user'

  def create
  	if verify_recaptcha
      super
      # session[:omniauth] = nil unless @user.new_record?
  	else
      build_resource(sign_up_params)
      clean_up_passwords(resource)
      flash.now[:alert] = "There was an error with the recaptcha code below. Please re-enter the code."      
      flash.delete :recaptcha_error
      render :new
  	end
  end

  def build_resource(*args)
    super
    if session[:omniauth]
      @user.apply_omniauth(session[:omniauth])
      @user.valid?
    end
  end
end
