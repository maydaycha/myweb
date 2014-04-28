class Users::ConfirmationsController < Devise::ConfirmationsController
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
