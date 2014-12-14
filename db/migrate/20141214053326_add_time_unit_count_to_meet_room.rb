class AddTimeUnitCountToMeetRoom < ActiveRecord::Migration
  def change
  	add_column :meet_rooms, :time_unit_count, :integer
  end
end
