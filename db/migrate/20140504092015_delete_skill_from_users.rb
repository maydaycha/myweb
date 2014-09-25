class DeleteSkillFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :skill, :string
    remove_column :user_skills, :user_skill_category_id, :integer
    rename_column :user_skills, :skill, :name
  end
end
