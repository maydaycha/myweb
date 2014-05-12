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
