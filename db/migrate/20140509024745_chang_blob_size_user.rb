class ChangBlobSizeUser < ActiveRecord::Migration
  def change
    change_column :users, :picture, :blob, :limit => 10.megabyte
  end
end
