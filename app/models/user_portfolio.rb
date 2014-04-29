class UserPortfolio < ActiveRecord::Base
  belongs_to :user
  has_one :user_skill_category
  has_one :user_skill
end
