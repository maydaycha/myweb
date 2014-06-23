class AdminUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :trackable, :validatable, :rememberable

  def is_admin?
    # self.email && ENV['ADMIN_EMAILS'].to_s.include?(self.email)
    return true
  end
  
end
