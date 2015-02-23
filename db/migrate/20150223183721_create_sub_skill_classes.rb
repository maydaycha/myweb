class CreateSubSkillClasses < ActiveRecord::Migration
  def change
    create_table :sub_skill_classes do |t|
      t.string :name
      t.integer :main_skill_class_id
      t.timestamps
    end
  end
end
