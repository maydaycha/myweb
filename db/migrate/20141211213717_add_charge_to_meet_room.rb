class AddChargeToMeetRoom < ActiveRecord::Migration
  def change
  	add_column :meet_rooms, :charge, :integer, default: 0
  end
end
