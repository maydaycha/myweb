class RenameColumnUserSkillCategory < ActiveRecord::Migration
  def change
    change_column :user_skill_categories, :sub_skill_id, :string
  end
end
