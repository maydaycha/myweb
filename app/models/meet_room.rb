class MeetRoom < ActiveRecord::Base
	 has_many :project
	 has_many :meet_room_members
end