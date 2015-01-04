class CreateMeetRoomMembers < ActiveRecord::Migration
  def change
    create_table :meet_room_members do |t|
      t.integer :user

      t.timestamps
    end
  end
end
