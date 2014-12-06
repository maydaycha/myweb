class MeetRoom < ActiveRecord::Base
	 has_many :project
	 has_many :meet_room_members, dependent: :destroy

	 validates :room_number, presence: true
end