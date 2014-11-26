class MeetRoomsController < ApplicationController
	def index
		@rooms = MeetRoom.all
	end

	def create
		@room = MeetRoom.new(room_params)
		if @room.save
			redirect_to meet_rooms_path
		else
			render :booking
		end
	end

	def show
		
	end

	def show_status
		@rooms = MeetRoom.all
		render "meet_rooms/show_status.html.erb"
	end

	def booking
		@room = MeetRoom.new
		@projects = Project.all
		@room.ordered_customer = current_user.id
	end

	private

	def room_params
		params.require(:meet_room).permit(:room_number, :start_time, :end_time, :case, :ordered_customer)
	end
end

