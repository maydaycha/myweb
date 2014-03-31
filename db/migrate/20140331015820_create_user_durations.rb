class CreateUserDurations < ActiveRecord::Migration
  def change
    create_table :user_durations do |t|
      t.integer :user_id
      t.datetime :start_at
      t.boolean :is_head

      t.timestamps
    end
  end
end
