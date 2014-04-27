class DeleteProfileAndAddColumnToUser < ActiveRecord::Migration
  def change
    drop_table :users_profiles
  end
end
