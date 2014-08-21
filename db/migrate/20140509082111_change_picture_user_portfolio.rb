class ChangePictureUserPortfolio < ActiveRecord::Migration
  def change
    change_column :user_portfolios, :picture1, :binary, :limit => 10.megabyte
    change_column :user_portfolios, :picture2, :binary, :limit => 10.megabyte
  end
end
