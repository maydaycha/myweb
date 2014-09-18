class AddLocationToProjects < ActiveRecord::Migration
  def change
  	rename_column :projects, :worker_locarion, :worker_location
  end
end
