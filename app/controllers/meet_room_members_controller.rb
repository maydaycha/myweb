class MeetRoomMembersController < ApplicationController
	before_action :authenticate_user!
	
	def index
		@room = MeetRoom.all.find_by_ordered_customer(current_user.id)
	end
	def create
		@room = MeetRoom.all.find_by_ordered_customer(current_user.id)
		@member = @room.meet_room_members.build(member_params)
		
		if @member.save
			redirect_to meet_rooms_check_order_information_path
		else
			render :new
		end
	end

	def new
		select_member
		@member = @room.meet_room_members.build
	end

	def destroy
		@member = @room.meet_room_members.find(params[:id])
		@member.destroy
		redirect_to meet_room_meet_room_members_path
	end


	def select_member
		#if current_user.current_role[0] == 'p' 如果是僱主，能邀請所有人
    #  @project_member = 
    #elsif current_user.current_role[0] == 'c' 如果是受僱者，只能邀請僱主
    #  @project_member = 
	  #end
	  @room = MeetRoom.all.find_by_ordered_customer(current_user.id)
		@project = Project.find(@room.case)
		
		#MeetRoomMeber.exists?(user: project_members.user)
	  @project_members = @project.project_members
	end

	private

	def member_params
		params.require(:meet_room_member).permit(:user)
	end
end
