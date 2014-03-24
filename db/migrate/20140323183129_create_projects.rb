class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :outside_id
      t.string :name
      t.string :url
      t.float :budget
      t.string :require_skills
      t.datetime :remain_time
      t.datetime :duration
      t.string :from_source
      t.text :description

      t.timestamps
    end
  end
end
