class AddPageToSeo < ActiveRecord::Migration
  def change
    add_column :seos, :page, :text
  end
end
