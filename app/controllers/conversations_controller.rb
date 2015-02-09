class ConversationsController < ApplicationController
	before_filter :authenticate_user!
  helper_method :mailbox, :conversation

	def create
		recipient_emails = conversation_params(:recipients).split(',')
		recipients = User.where(email: recipient_emails).all

		conversation = current_user.send_message(recipients, *conversation_params(:body, :subject)).conversation

		redirect_to conversation_path(conversation)
	end


	private

	def mailbox
    @mailbox ||= current_user.mailbox
  end

  def conversation
    @conversation ||= mailbox.conversations.find(params[:id])
  end

  def conversation_params(*keys)
    fetch_params(:conversation, *keys)
  end

  def fetch_params(key, *subkeys)
    params[key].instance_eval do
      case subkeys.size
      when 0 then self
      when 1 then self[subkeys.first]
      else subkeys.map{|k| self[k] }
      end
    end
  end
  
end
