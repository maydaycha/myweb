class MeetRoomsController < ApplicationController
	before_action :authenticate_user!
	layout "meet_room"
	WAIT_TIME = (60*60*24*3) #60sec * 60min * 24hr * 3days

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

	
	def edit
		@room = MeetRoom.find(params[:id])
		@projects = Project.all #暫時先抓出所有project，之後要修改成該user所建立的project
	end

	def update
		@room = MeetRoom.find(params[:id])
		if @room.update(room_params)
			redirect_to meet_rooms_check_order_information_path
		else
			render :edit
		end
	end


	def booking
		@room = MeetRoom.new
		@projects = Project.all #暫時先抓出所有project，之後要修改成該user所建立的project
		#@meet_room_price = MeetRoomPrice.find(level: user.level)
		@meet_room_price = MeetRoomPrice.first
	end

	def check_order_information
		@rooms = MeetRoom.where("ordered_customer = ?", current_user.id)
		@projects = []
		@rooms.each do |room|
			@projects << Project.find(room.case)
			@unconfirmed = room.meet_room_members.where("confirmed = ?", 0).count
			#@join = 
			#not_joined = 
			@final_datetime = room.created_at + WAIT_TIME
		end

	end


	private

	def room_params
		params.require(:meet_room).permit(:room_number, :start_time, :end_time, :case, :ordered_customer, :target_date)
	end



end
