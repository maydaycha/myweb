class ChangBlobInUsers < ActiveRecord::Migration
  def change
    change_column :users, :picture, :binary, :limit => 10.megabyte
  end
end
