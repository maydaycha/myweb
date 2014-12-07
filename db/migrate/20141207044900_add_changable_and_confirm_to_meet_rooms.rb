class AddChangableAndConfirmToMeetRooms < ActiveRecord::Migration
  def change
  	add_column :meet_rooms, :is_changable, :boolean, default: true
  	add_column :meet_rooms, :is_confirmed, :boolean, default: false
  end
end
