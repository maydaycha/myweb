class AddPublicMessageChineseToProject < ActiveRecord::Migration
  def change
    add_column :projects, :public_message_chinese, :text
  end
end
