class MeetRoomsController < ApplicationController
	before_action :authenticate_user!
	layout "meet_room"

	def index
		@rooms = MeetRoom.all
	end

	def create
		@room = MeetRoom.new(room_params)
		@room.ordered_customer = current_user.id
		if @room.save
			redirect_to new_meet_room_meet_room_member_path(@room)
		else
			render :booking
		end
	end

	


	def booking
		@room = MeetRoom.new
		@projects = Project.all #暫時先抓出所有project，之後要修改成該user所建立的project
	end

	def check_order_information
		@rooms = MeetRoom.where("ordered_customer = ?", current_user.id)
		
	end



	private

	def room_params
		params.require(:meet_room).permit(:room_number, :start_time, :end_time, :case, :ordered_customer)
	end
end
