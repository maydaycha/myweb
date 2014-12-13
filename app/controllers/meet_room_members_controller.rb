class MeetRoomMembersController < ApplicationController
	before_action :authenticate_user!
	layout "meet_room"

	
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
		#if currrent_user.current_role == null 代表為受雇者
		#if current_user.current_role[0] == 'p' 代表是一般僱主，能邀請所有人
    #  @project_member = 
    #elsif current_user.current_role[0] == 'c' 代表企業方案的僱者
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
