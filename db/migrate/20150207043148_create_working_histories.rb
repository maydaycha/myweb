class CreateWorkingHistories < ActiveRecord::Migration
  def change
    create_table :working_histories do |t|
    	t.integer :user_id
    	t.integer :project_id
    	t.integer :mouseClick
    	t.integer :keyboardClick
    	t.integer :lastWorkingTimestamp
    	t.integer :todayWorkingHours
    	t.integer :weekWorkingHours

    	t.time :day_start_count_at
    	t.time :week_start_count_at
      t.timestamps
    end
  end
end
