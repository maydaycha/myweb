class CreateMeetRooms < ActiveRecord::Migration
  def change
    create_table :meet_rooms do |t|
      t.integer :room_number
      t.datetime :start_time
      t.datetime :end_time
      t.integer :case
      t.integer :ordered_customer

      t.timestamps
    end
  end
end
