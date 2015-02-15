class MeetRoomsController < ApplicationController
	
	
	before_action :authenticate_user!
	before_action :set_headers


	def index
		@rooms = MeetRoom.all
	end

	def create
		@room = MeetRoom.new(room_params)
		@room.ordered_customer = current_user.id
		@room.room_number = 1 # should be modified
		
		@project = Project.find(room_params[:case])

		@project.project_members.each do |p|  #save all project_member to meet_room_member  => default
			@members = @room.meet_room_members.build(user: p.user)
		end

		if @room.save! && @members.save!
			meet_room_notification(@room, @project.project_members, @room)  #send notification to all meet_room member 
			redirect_to meet_rooms_booking_path
		else
			render :booking, status: :create_success
		end
	end

	def edit
		@room = MeetRoom.find(params[:id])
		@projects = Project.all #暫時先抓出所有project，之後要修改成該user所建立的project
		
		@project = Project.find(@room.case)
		@project_members = @project.project_members

		if @room.meet_room_members
			@meet_room_members = @room.meet_room_members
		else
			@meet_room_members = nil
		end
		render :json => { :form => render_to_string(:partial => 'edit_form')}

	end

	def update
		@room = MeetRoom.find(params[:id])
		if @room.update(room_params)
			render :waiting_meet
		else
			render :edit
		end
	end

	def destroy
		@room = MeetRoom.find(params[:id])

		if @room.destroy
			redirect_to meet_rooms_path
		else
			redirect_to meet_rooms_check_order_information_path
		end
	end

	def booking
		@room = MeetRoom.new
		@projects = Project.all #暫時先抓出所有project，之後要修改成該user所建立的project
		#@meet_room_price = MeetRoomPrice.find(level: user.level)
		@meet_room_price = MeetRoomPrice.find_by_scheme(:general)  # todo: different user level will change the price
	end

	def enterprise
		@room = MeetRoom.new
		@projects = Project.all #暫時先抓出所有project，之後要修改成該user所建立的project
		#@meet_room_price = MeetRoomPrice.find(level: user.level)
		@meet_room_price = MeetRoomPrice.find_by_scheme(:enterprise)	
	end

	def byot
		@room = MeetRoom.new
		@projects = Project.all #暫時先抓出所有project，之後要修改成該user所建立的project
		#@meet_room_price = MeetRoomPrice.find(level: user.level)
		@meet_room_price = MeetRoomPrice.find_by_scheme(:byot)
	end


	def waiting_meet
		
	end

	def get_waiting_case
		@rooms = MeetRoom.where("ordered_customer = ? AND meet_type = ?", current_user.id, CASE_MEET)
		@projects = []
		@unconfirmed = []
		events = []

		@rooms.each do |room|
			@projects << Project.find(room.case)
			@unconfirmed << room.meet_room_members.where("confirmed = ?", 0).count
			events << {:id => room.id, :title => room.subject, :start => "#{room.start_time}", :end => "#{room.end_time}"}
		end
		render :text => events.to_json
	end

	
	def get_waiting_interview
		@rooms = MeetRoom.where("ordered_customer = ? AND meet_type = ?", current_user.id, INTERVIEW_MEET)
		@projects = []
		@unconfirmed = []
		events = []

		@rooms.each do |room|
			@projects << Project.find(room.case)
			@unconfirmed << room.meet_room_members.where("confirmed = ?", 0).count
			events << {:id => room.id, :title => room.subject, :start => "#{room.start_time}", :end => "#{room.end_time}"}
		end
		render :text => events.to_json
	end
	

	def upcoming_meet
		
	end

	def get_upcoming
		@rooms = MeetRoom.where("ordered_customer = ?", current_user.id)
		@projects = []
		@unconfirmed = []
		events = []

		@rooms.each do |room|
			@projects << Project.find(room.case)
			@unconfirmed << room.meet_room_members.where("confirmed = ?", 0).count
			#@join = 
			#not_joined = 
			#@final_change_datetime = room.target_date - BEFORE_TARGET_DATE
			#@rent_time = room.time_unit_count * TIME_UNIT
			#@charge = room.time_unit_count * MeetRoomPrice.first.price # to-do : modify by different scheme
			events << {:id => room.id, :title => room.subject, :start => "#{room.start_time}", :end => "#{room.end_time}"}
		end
		render :text => events.to_json
	end

	def get_all_meet
		@rooms = MeetRoom.all
		@projects = []
		events = []

		@rooms.each do |room|
			@projects << Project.find(room.case)
			events << {:id => room.id, :title => "已佔用", :start => "#{room.start_time}", :end => "#{room.end_time}"}
		end
		render :text => events.to_json
	end

	def finished_meet
		
	end

	def get_finished
		@rooms = MeetRoom.where("end_time < ?", Time.now)
		@projects = []
		@unconfirmed = []
		events = []

		@rooms.each do |room|
			@projects << Project.find(room.case)
			@unconfirmed << room.meet_room_members.where("confirmed = ?", 0).count
			#@join = 
			#not_joined = 
			#@final_change_datetime = room.target_date - BEFORE_TARGET_DATE
			#@rent_time = room.time_unit_count * TIME_UNIT
			#@charge = room.time_unit_count * MeetRoomPrice.first.price # to-do : modify by different scheme
			events << {:id => room.id, :title => room.subject, :start => "#{room.start_time}", :end => "#{room.end_time}"}
		end
		render :text => events.to_json
	end

# to cancel the meet_room order
	def cancel
		@room = MeetRoom.find(params[:id])
		@diff_day = (@room.target_date).day - (Time.now).day 
		@refund_percent = 0 

		REFUND_PERCENT.each_with_index do |refund, i|
			if @diff_day <= refund[0]
				@refund_percent = refund[1]
				break
			end

			@refund_percent = REFUND_PERCENT.last[1]  #mean it the last one in the REFUND_PERCENT
		end
	end

	def detail
		@room = MeetRoom.find(params[:id])
		render :json => @room.to_json
	end


	def update_members
		#@room = meet_room_id
		@project = Project.find(params[:project_id])
		@project_members = @project.project_members

		render :json => { :form => render_to_string(:partial => 'update_members')}
	end

	def meet_room_notification(room, member, meet_room)
		recipients = User.find_by_id(member)
		conversation = current_user.send_message(recipients, room.description, room.subject, true).conversation
	end

	private
	CASE_MEET = 1
	INTERVIEW_MEET = 2
	TIME_UNIT = 30  # 30min per unit
	BEFORE_TARGET_DATE = 3 		#60sec * 60min * 24hr * 3days
	REFUND_PERCENT = [[3, 30], [6, 40], [9, 50], [13, 70], [14, 100]]
	def room_params
		params.require(:meet_room).permit(:room_number, 
																			:start_time, 
																			:end_time, 
																			:case, 
																			:ordered_customer, 
																			:meet_type, 
																			:time_unit_count,
																			:subject,
																			:description, 
																			meet_room_members_attribute: [:id, :user, :meet_room_id, :confirmed])
	end

	def conversation
    @conversation ||= mailbox.conversations.find(params[:id])
  end

  


end

