class AddSkillCategoryToUserSill < ActiveRecord::Migration
  def change
    add_column :user_skills, :user_skill_category_id, :integer
  end
end
