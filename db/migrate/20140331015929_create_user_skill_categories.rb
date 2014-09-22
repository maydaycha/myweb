class CreateUserSkillCategories < ActiveRecord::Migration
  def change
    create_table :user_skill_categories do |t|
      t.integer :user_id
      t.integer :main_skill_id
      t.integer :sub_skill_id

      t.timestamps
    end
  end
end
