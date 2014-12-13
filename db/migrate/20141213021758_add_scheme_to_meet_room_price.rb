class AddSchemeToMeetRoomPrice < ActiveRecord::Migration
  def change
		add_column :meet_room_prices, :scheme, :string
  end
end
