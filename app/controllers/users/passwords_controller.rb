class Users::PasswordsController < Devise::PasswordsController

def update
    if params[:user][:password].blank?
        flash[:alert] = "未填入密碼: 請檢查密碼"
        redirect_to :back
    elsif params[:user][:password] != params[:user][:password_confirmation]
        flash[:alert] = "密碼不一致檢查: 請重複檢查您輸入的密碼"
        redirect_to :back
    elsif params[:user][:password].length < 8
        flash[:alert] = "密碼長度不足: 密碼不得少於八個英數字元，不包含特殊符號"
        redirect_to :back
    else
        super
    end
end

  def edit
    super
    original_token = params[:reset_password_token]
    reset_password_token = Devise.token_generator.digest(self, :reset_password_token, original_token)
    user = User.find_by_reset_password_token(reset_password_token)
    if user
      resource.username = user.username
    end
  end

  def after_sending_reset_password_instructions_path_for(resource_name)
    email_success_path
  end

end
