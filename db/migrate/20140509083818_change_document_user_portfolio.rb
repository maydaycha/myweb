class ChangeDocumentUserPortfolio < ActiveRecord::Migration
  def change
    change_column :user_portfolios, :document, :binary, :limit => 50.megabyte
  end
end
