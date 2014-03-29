class CreateTranslators < ActiveRecord::Migration
  def change
    create_table :translators do |t|
      t.string :account
      t.string :password

      t.timestamps
    end
  end
end
