class MessagesController < ApplicationController
	layout "message"
	before_action :authenticate_user!


	def create
		
	end

	def show
		@message = current_user.messages.find(params[:id])
	end
	def inbox
		@inbox = mailbox.inbox
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
