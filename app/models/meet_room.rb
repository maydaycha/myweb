class MeetRoom < ActiveRecord::Base
	 has_many :project
	 has_many :meet_room_members, dependent: :destroy
	 accepts_nested_attributes_for :meet_room_members

	 validates :room_number, presence: true
	 validates :start_time, presence: true
	 
end