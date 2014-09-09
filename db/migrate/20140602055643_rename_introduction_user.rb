class RenameIntroductionUser < ActiveRecord::Migration
  def change
    rename_column :users, :introduction, :brief_introduction
    rename_column :users, :review, :introduction
  end
end
