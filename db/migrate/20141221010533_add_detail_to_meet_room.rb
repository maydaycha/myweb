class AddDetailToMeetRoom < ActiveRecord::Migration
  def change
  	add_column :meet_rooms, :subject, :string
  	add_column :meet_rooms, :description, :text
  end
end
