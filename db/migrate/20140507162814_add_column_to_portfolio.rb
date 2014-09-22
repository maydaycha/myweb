class AddColumnToPortfolio < ActiveRecord::Migration
  def change
    add_column :user_portfolios, :document, :blob
  end
end
