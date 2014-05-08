class Users::PasswordsController < Devise::PasswordsController

  def edit
    super
    original_token = params[:reset_password_token]
    reset_password_token = Devise.token_generator.digest(self, :reset_password_token, original_token)
    user = User.find_by_reset_password_token(reset_password_token)

    if user
      resource.username = user.username
    end
  end

end
