class AddUserIdToMessageOfProjects < ActiveRecord::Migration
  def change
  	add_column :messages_of_projects, :user_id, :integer
  end
end
