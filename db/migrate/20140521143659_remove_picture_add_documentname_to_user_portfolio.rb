class RemovePictureAddDocumentnameToUserPortfolio < ActiveRecord::Migration
  def change
    remove_column :user_portfolios, :picture2, :binary, :limit => 10.megabyte
    add_column :user_portfolios, :document_name, :string
    rename_column :user_portfolios, :document, :document_content
  end
end
