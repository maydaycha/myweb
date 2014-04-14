class CreateUserTranslations < ActiveRecord::Migration
  def change
    create_table :user_translations do |t|
      t.integer :user_id
      t.string :language
      t.string :description_in_short
      t.text :description_in_short
      t.timestamps
    end
    add_column :users, :description_in_short, :string
    add_column :users, :description_in_detail, :text
  end
end
