class CreateOauths < ActiveRecord::Migration
  def change
    create_table :oauths do |t|
      t.string :name
      t.string :token
      t.string :secret

      t.timestamps
    end
  end
end
