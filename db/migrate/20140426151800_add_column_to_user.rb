class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :image, :string
    add_column :users, :worker_type, :integer
    add_column :users, :skill, :integer
    add_column :users, :hourly_pay, :float
    add_column :users, :city, :string
  end
end
