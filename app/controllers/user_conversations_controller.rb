class UserConversationsController < ApplicationController

  def index
    @user = User.find params[:user_id]
    @conversations = @user.user_conversations
  end

  def show
    # return render json: params
    @conversation = UserConversation.find params[:id]
    @user = User.find params[:user_id]
  end

  def new
    redirect_to users_path unless current_user

    @user = User.find params[:user_id]
    @sms_conversation = @user.user_conversations.build
    @sms_conversation.build_conversation.messages.build
    # render json: @conversation
  end

  def create
    redirect_to users_path unless current_user

    @conversation = UserConversation.new params.permit![:user_conversation]
    @conversation.user = current_user
    @conversation.conversation.messages.first.user = current_user
    @conversation.save!
    redirect_to user_sms_conversation_path(current_user, @conversation)
  end

  def mark_as_read
    @conversation = UserConversation.find params[:id]
    @conversation.update_attributes :read => true
    redirect_to user_conversation_path(current_user, @conversation)
  end

  def mark_as_unread
    @conversation = UserConversation.find params[:id]
    @conversation.update_attributes :read => false
    redirect_to user_conversation_path(current_user, @conversation)
  end
end
