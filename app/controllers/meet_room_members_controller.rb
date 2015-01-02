class MeetRoomMembersController < ApplicationController
	before_action :authenticate_user!
	#layout "meet_room_information"

	
	def index
		@room = MeetRoom.all.find_by_ordered_customer(current_user.id)
	end
	def create
		@room = MeetRoom.find(params[:meet_room_id]) 
		@member = @room.meet_room_members.build(member_params)
		# todo : save to contact_person
		
		if @member.save
			redirect_to meet_rooms_detail_path(@room)
		else
			render :new
		end
	end

	def new
		@room = MeetRoom.find_by_id(params[:meet_room_id])
		@member = @room.meet_room_members.build
		@project = Project.find(@room.case)
		@project_members = @project.project_members
	end

	def destroy
		@member = @room.meet_room_members.find(params[:id])
		@member.destroy
		render :index
	end

	def get_contact_person
		#case_contact
		#enterprise_contact
		#BYOT_contact
		#interview_contact
		@project = Project.all.first #todo : pick all member in the all projects    
		@project_members = @project.project_members
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
