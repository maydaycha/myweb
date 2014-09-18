class AddIsEmergencyToProject < ActiveRecord::Migration
  def change
  	add_column :projects, :is_emergency, :boolean, :default => false
  end
end
