class AddServiceToActiveAdmin < ActiveRecord::Migration
  def change
    add_column :admin_users, :is_service, :boolean, :default => false
  end
end
