class UserAuthentication < ActiveRecord::Base

  devise :database_authenticatable, :registerable

  belongs_to :user

end
