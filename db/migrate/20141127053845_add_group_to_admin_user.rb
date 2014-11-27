class AddGroupToAdminUser < ActiveRecord::Migration
  def change
    add_column :admin_users, :authority_group_id, :integer
  end
end
