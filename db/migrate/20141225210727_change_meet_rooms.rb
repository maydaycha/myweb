class ChangeMeetRooms < ActiveRecord::Migration
  def change
  	change_column :meet_rooms, :start_time, :datetime
  	change_column :meet_rooms, :end_time, :datetime
  	remove_column :meet_rooms, :target_date, :date
  end
end

