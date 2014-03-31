class ProjectPublicMessagesController < ApplicationController
  def index
    @messages = ProjectPublicMessage.all
  end

  def show
    @message = ProjectPublicMessage.find(params[:id])
  end

  def edit
    @message = ProjectPublicMessage.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @message.to_json }
    end
  end

  def update
    @message = ProjectPublicMessage.find(params[:message])
    @message.update(params.permit![:message])
    redirect_to project_path(@message)
  end


  def edit_via_project
    @message = ProjectPublicMessage.find_by_project_id(params[:project_id])
    respond_to do |format|
      format.html
      format.json { render :json => @message.to_json }
    end
  end
end
