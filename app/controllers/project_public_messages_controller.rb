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
    begin
      @message = ProjectPublicMessage.find_by_project_id(params[:project_id])
      respond_to do |format|
        format.html
        format.json { render :json => { :status => "success", :data => @message } }
      end
    rescue
      render :json => { :status => "fail" }
    end
  end

  def update_via_project
    if params[:text] && params[:projectId]
      @message = ProjectPublicMessage.find_by_project_id(params[:projectId])
      @message.text_chinese = params[:text]
      @message.save
      render :json => { :status => "success"}
    else
      render :json => { :status => "fail"}
    end
  end


  def set_word_count
    @messges = ProjectPublicMessage.order(:id)
    @messges.each do |m|
      content =  m.text.gsub(/[(,) ]/," ").split(/ /).delete_if {|item| item == '' }
      m.word_count = content.length
      m.save
    end
    render :json => { :name_count => "123", :data => @temp }
  end
end
