class CreateProjectMembers < ActiveRecord::Migration
  def change
    create_table :project_members do |t|
      t.integer :user
      t.integer :project_id

      t.timestamps
    end
  end
end
