class MeetRoomsController < ApplicationController
	def index
		@rooms = MeetRoom.all
	end

	def create
		@room = MeetRoom.new(room_params)
		@room.ordered_customer = current_user.id
		if @room.save
			redirect_to meet_rooms_check_order_information_path
		else
			render :booking
		end
	end

	def booking
		@room = MeetRoom.new
		@projects = Project.all
	end

	def check_order_information
		@room = MeetRoom.all.find_by_ordered_customer(current_user.id)
		@project = Project.find(@room.case)
		
	end

	def participant
		@room = MeetRoom.all.find_by_ordered_customer(current_user.id)
		@project = Project.find(@room.case)
		@member = @room.project_members.build
	end

	private

	def room_params
		params.require(:meet_room).permit(:room_number, :start_time, :end_time, :case, :ordered_customer)
	end
end
