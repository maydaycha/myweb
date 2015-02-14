class CreateMemos < ActiveRecord::Migration
  def change
    create_table :memos do |t|
      t.integer :user_id
      t.integer :project_id
      t.text :memoContent

      t.timestamps
    end
  end
end
