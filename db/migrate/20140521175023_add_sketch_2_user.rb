class AddSketch2User < ActiveRecord::Migration
  def change
    add_column :users, :sketch, :string
  end
end
