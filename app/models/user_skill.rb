class UserSkill < ActiveRecord::Base
    belongs_to :user
    has_one :user_skill_category
end
