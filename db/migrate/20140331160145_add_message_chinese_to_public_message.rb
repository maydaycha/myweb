class AddMessageChineseToPublicMessage < ActiveRecord::Migration
  def change
    add_column :project_public_messages, :text_chinese, :text
  end
end
