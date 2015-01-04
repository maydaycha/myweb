class AddMeetRoomIdToMeetRoomMember2 < ActiveRecord::Migration
  def change
  	add_column :meet_room_members, :meet_room_id, :integer
  end
end
