class ChangeColumnUserProtfolios < ActiveRecord::Migration
  def change
    remove_column :user_portfolios, :path, :string
    remove_column :user_portfolios, :url, :string
    remove_column :user_portfolios, :user_skill_id, :integer
    change_column :user_portfolios, :complete_time, :date
    add_column :user_portfolios, :title, :string
    remove_column :user_portfolios, :user_skill_category_id, :integer
    add_column :user_portfolios, :main_skill_id, :integer
    add_column :user_portfolios, :sub_skill_id, :integer
    add_column :user_portfolios, :picture1, :blob
    add_column :user_portfolios, :picture2, :blob
  end
end
