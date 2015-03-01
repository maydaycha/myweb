class CreateLocales < ActiveRecord::Migration
  def change
    create_table :locales do |t|
      t.string :name
      t.string :file_name
      t.boolean :active

      t.timestamps
    end
  end
end
