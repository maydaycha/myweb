class CreateSeos < ActiveRecord::Migration
  def change
    create_table :seos do |t|
      t.string :key
      t.string :content
      t.timestamps
    end
  end
end
