class MeetRoomMembersController < ApplicationController
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
		@member = @room.meet_room_members.new
	end



	private

	def member_params
		params.require(:meet_room_member).permit(:user)
	end
end
