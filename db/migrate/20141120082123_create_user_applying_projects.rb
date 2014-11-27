class CreateUserApplyingProjects < ActiveRecord::Migration
  def change
    create_table :user_applying_projects do |t|
      t.integer :user_id
      t.integer :project_id
      t.float :expect_hourly_charge
      t.text :introduction
      t.text :question1
      t.text :question2
      t.text :question3
      t.binary :attachment
      t.timestamps
    end
  end
end
