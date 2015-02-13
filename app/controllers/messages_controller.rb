class MessagesController < ApplicationController
	layout "message"
	before_action :authenticate_user!


	def create
		
	end

	def show

	end
	def inbox
		@inbox = current_user.messages
	end

	def trash
    current_user.mark_as_deleted conversation
    render :inbox
  end

	private

  def mailbox
    @mailbox ||= current_user.mailbox
  end

  def message
    @message ||= mailbox.conversations.find(params[:id])
  end
end
