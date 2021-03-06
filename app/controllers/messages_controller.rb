class MessagesController < ApplicationController
	layout "message"
	before_action :authenticate_user!


	def create
		
	end

	def show
		@message = current_user.messages.find_by_conversation_id(params[:id])
		meet_id = current_user.mailbox.notifications.find_by_subject(@message.subject).notified_object_id
		@meet = MeetRoom.find(meet_id)

	end

	def inbox
		@box = mailbox.inbox
	end

	def sentbox
		@box = mailbox.sentbox
	end

	def trash
		@box = @mailbox.trash
    current_user.mark_as_deleted conversation
    render :inbox
  end

  def destroy
  	
  end

  def empty_trash
  	
  end

	private

  def mailbox
    @mailbox ||= current_user.mailbox
  end

  def message
    @message ||= mailbox.conversations.find(params[:id])
  end
end
