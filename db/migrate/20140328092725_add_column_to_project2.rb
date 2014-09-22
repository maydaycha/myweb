class AddColumnToProject2 < ActiveRecord::Migration
  def change
    add_column :projects, :translators, :integer, :default => 0
  end
end
