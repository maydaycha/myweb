class AddDayToMeetRoom < ActiveRecord::Migration
  def change
  	add_column :meet_rooms, :target_date, :date
  	change_column :meet_rooms, :start_time, :time
  	change_column :meet_rooms, :end_time, :time
  end
end
