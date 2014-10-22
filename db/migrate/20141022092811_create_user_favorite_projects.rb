class CreateUserFavoriteProjects < ActiveRecord::Migration
  def change
    create_table :user_favorite_projects do |t|
      t.integer :project_id
      t.integer :user_id
      t.timestamps
    end
  end
end
