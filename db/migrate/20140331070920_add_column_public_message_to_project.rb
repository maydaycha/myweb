class AddColumnPublicMessageToProject < ActiveRecord::Migration
  def change
    add_column :projects, :public_message, :text
  end
end
