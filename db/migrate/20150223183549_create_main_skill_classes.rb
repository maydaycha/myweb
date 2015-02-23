class CreateMainSkillClasses < ActiveRecord::Migration
  def change
    create_table :main_skill_classes do |t|
      t.string :name
      t.binary :picture, limit: 2147483647
      t.timestamps
    end
  end
end
