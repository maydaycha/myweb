class CreateWorkingHistories < ActiveRecord::Migration
  def change
    create_table :working_histories do |t|
    	t.integer :user_id
    	t.integer :project_id
    	t.integer :mouseClick
    	t.integer :keyboardClick
    	t.integer :lastWorkingTimestamp
    	t.time :todayWorkingHours, default: 0
    	t.time :weekWorkingHours, default: 0

      t.time :work_start_at
    	t.time :day_start_count_at
    	t.time :week_start_count_at
      t.timestamps
    end
  end
end
