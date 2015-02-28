class CreateSearchManagements < ActiveRecord::Migration
  def change
    create_table :search_managements do |t|
      t.string :category
      t.boolean :allow_internal
      t.boolean :allow_external
      t.timestamps
    end
  end
end
