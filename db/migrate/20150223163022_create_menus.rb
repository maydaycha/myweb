class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :key
      t.string :label
      t.string :link
      t.timestamps
    end
  end
end
