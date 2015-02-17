class CreateMeetRoomPrices < ActiveRecord::Migration
  def change
    create_table :meet_room_prices do |t|
      t.integer :level 
      t.integer :price 

      t.timestamps
    end
  end
end
