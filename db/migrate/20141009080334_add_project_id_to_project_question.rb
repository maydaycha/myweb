class AddProjectIdToProjectQuestion < ActiveRecord::Migration
  def change
  	add_column :project_questions, :project_id, :integer
  end
end
