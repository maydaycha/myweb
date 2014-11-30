class ProjectMember < ActiveRecord::Base
	belongs_to :project
	belongs_to :meet_room
	
end
