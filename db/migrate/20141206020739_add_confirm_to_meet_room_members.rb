class AddConfirmToMeetRoomMembers < ActiveRecord::Migration
  def change
  	add_column :meet_room_members, :confirmed, :integer, default: 0
  end
end
