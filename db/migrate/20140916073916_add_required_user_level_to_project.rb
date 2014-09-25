class AddRequiredUserLevelToProject < ActiveRecord::Migration
  def change
  	add_column :projects, :required_user_level, :integer, :default => 1
  	add_column :projects, :work_type, :integer, :default => nil
  	add_column :projects, :visibility, :integer, :default => 1
  	add_column :projects, :file, :binary, :limit => 5.megabyte
  	add_column :projects, :satisfication, :integer, :default => nil
  	add_column :projects, :worked_hours, :integer, :default => nil
  	add_column :projects, :worker_locarion, :string
  	add_column :projects, :english_level, :integer
  	add_column :projects, :required_user_intro, :boolean, :default => false
  	add_column :projects, :payment_type, :integer, :default => 1
  end
end
