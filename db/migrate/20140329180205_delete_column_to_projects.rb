class DeleteColumnToProjects < ActiveRecord::Migration
  def change
    remove_column :projects, :duration
    remove_column :projects, :remain_time
  end
end
