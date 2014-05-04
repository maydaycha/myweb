class CreateUserFavorites < ActiveRecord::Migration
  def change
    create_table :user_favorites do |t|
      t.integer :favorite_user_id
      t.integer :user_id
      t.timestamps
    end
  end
end
