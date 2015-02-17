class AddMeetTypeToMeetRoom < ActiveRecord::Migration
  def change
  	add_column :meet_rooms, :meet_type, :integer
  end
end
