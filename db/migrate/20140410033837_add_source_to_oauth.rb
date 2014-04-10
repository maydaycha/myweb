class AddSourceToOauth < ActiveRecord::Migration
  def change
    add_column :oauths, :source, :string
  end
end
