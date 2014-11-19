class AddUserIdToMessageOfProjects < ActiveRecord::Migration
  def change
  	add_column :message_of_projects, :user_id, :integer
  end
end
