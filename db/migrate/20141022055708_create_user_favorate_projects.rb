class CreateUserFavorateProjects < ActiveRecord::Migration
  def change
    create_table :user_favorate_projects do |t|
      t.integer  "favorite_project_id"
      t.integer  "user_id"
      t.timestamps
    end
  end
end
