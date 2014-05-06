class RenameColumnUserProtfolios < ActiveRecord::Migration
  def change
    rename_column :user_portfolios, :complete_time, :date
    remove_column :user_portfolios, :title, :string
    add_column :user_portfolios, :skill, :string
  end
end
