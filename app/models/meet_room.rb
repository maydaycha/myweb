class MeetRoom < ActiveRecord::Base
	 has_one :project
	 has_many :project_members
end