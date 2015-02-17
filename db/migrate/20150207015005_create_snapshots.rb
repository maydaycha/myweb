class CreateSnapshots < ActiveRecord::Migration
  def change
    create_table :snapshots do |t|
    	t.integer :user_id
    	t.integer :project_id
    	t.integer :mouseClickCount
      t.integer :keyboardClickCount
      t.string :snapshot
      t.text :memoContent
      t.timestamps
    end
  end
end

