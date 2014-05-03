class UserSkillCategory < ActiveRecord::Base
    has_many :user_skills
    belongs_to :user
end
