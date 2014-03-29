class AddColumnToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :currency, :integer, :default => 0
    add_column :projects, :start_date, :datetime
    add_column :projects, :end_date, :datetime
  end
end
