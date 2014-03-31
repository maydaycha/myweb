class AddColumnToUser < ActiveRecord::Migration
  def change
  	add_column :users, :social_login, :string
  	add_column :users, :social_id, :string
  end
end
