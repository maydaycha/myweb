class Users::ConfirmationsController < Devise::ConfirmationsController

  def create
    # override it all
    # super
    self.resource = resource_class.send_confirmation_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      flash[:notice] = t("devise.confirmations.resend_success")
      respond_with({}, location: after_resending_confirmation_instructions_path_for(resource_name))
    else
      respond_with(resource)
    end
  end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?

    if resource.errors.empty?
      set_flash_message(:notice, :confirmed) if is_flashing_format?
      respond_with_navigational(resource){ redirect_to after_confirmation_path_for(resource_name, resource) }
    else
      respond_with_navigational(resource.errors, status: :unprocessable_entity){ redirect_to after_confirmation_path_for(resource_name, resource) }
    end
  end

  def after_resending_confirmation_instructions_path_for(resource_name)
  	verify_user_registration_path(email: self.resource.email) if is_navigational_format?
  end

  # The path used after confirmation.
  def after_confirmation_path_for(resource_name, resource)
  	if signed_in?
  	  signed_in_root_path(resource)
  	else
  	  new_users_skill_category_path
  	  # new_session_path(resource_name)
  	end
  end
end
