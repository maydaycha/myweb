class AddMeetroomIdToMeetroomMember < ActiveRecord::Migration
  def change
  	add_column :meet_rooms, :meet_room_id, :integer
  end
end
