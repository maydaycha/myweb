class ProjectMembersController < ApplicationController

	def create
		@room = MeetRoom.all.find_by_ordered_customer(current_user.id)
		@project = Project.find(@room.case)

		@member = ProjectMember.new(member_params)
		@member.project_id = @project.id
		
		if @member.save
			redirect_to meet_rooms_check_order_information_path
		else
			render :new
		end
	end

	def new
		@room = MeetRoom.all.find_by_ordered_customer(current_user.id)
		@project = Project.find(@room.case)
		@member = @room.project_members.build
	end



	private

	def member_params
		params.require(:project_member).permit(:user_id, :project_id)
	end
end
