class AddDuringTimeToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :during_time, :string
  end
end
