class AddColumnToTranslator < ActiveRecord::Migration
  def change
    add_column :translators, :name, :string
    add_column :translators, :category, :integer, :default => 0
  end
end
