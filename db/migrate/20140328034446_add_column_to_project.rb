class AddColumnToProject < ActiveRecord::Migration
  def change
    add_column :projects, :project_category, :integer
    add_column :projects, :is_translation, :integer, :default => 0
  end
end
