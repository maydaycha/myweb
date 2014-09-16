class ChangeColumnNameInUsers < ActiveRecord::Migration
  def change
    rename_column :users, :description_in_short, :introduction
    rename_column :users, :description_in_detail, :review
  end
end
