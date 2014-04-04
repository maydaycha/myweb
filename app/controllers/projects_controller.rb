require 'oauth_token'
require 'json'
require "csv"

class ProjectsController < ApplicationController
  include Token

  before_filter :set_headers
  before_filter :get_access_token

  def index
    @projects = Project.all
    @category = ProjectCategory.all
    @translators = Translator.all
    respond_to do |format|
      format.html { render :html => [ @projects, @category] }
      format.json { render :json => @projects.to_json }
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  def edit
    @project = Project.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @project.to_json }
    end
  end

  def update
    @project = Project.find(params[:id])
    @project.update(params.permit![:project])
    redirect_to project_path(@project)
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path
  end

  def update_budget
    if @projects = Project.where(:project_category => params[:c])
      @projects.each do |ele, index|
        ele.budget = "#{ ele.budget.split(/,/)[0].to_i + params[:new_budget].to_i}, #{ ele.budget.split(/,/)[1].to_i + params[:new_budget].to_i}"
        ele.save
      end
    end
    render :json => { :data => params[:new_budget] , :category => params[:c] }
  end

  def get_access_token
    @access_token = construct_access_token
  end

  def get_project_by_translator
    puts session[:account]
    if session[:account]
      @translator = Translator.find_by_account(session[:account])
      if @translator
        @projects = Project.where(:translators => @translator['id'])
        if @projects
          @projects.each do |ele, index|
            @public_message = ProjectPublicMessage.where(:project_id => ele['outside_id']).take
            if @public_message
              ele['public_message'] = @public_message
            end
          end
          render :json => { :status => "success", :data => @projects }
        end
      end
    else
      render :json => { :status => "fail", :reason => "plase login"}
    end
  end

  def update_project_from_angular
    if params[:projectName] && params[:projectDescription] && params[:projectId]
      @p = Project.find(params[:projectId])
      @p.name_chinese = params[:projectName]
      @p.description_chinese = params[:projectDescription]
      @p.is_translation = 1
      @p.save
      render :json => { :status => "success" }
    else
      render :json => { :status => "fail" }
    end
  end

  def searchProjects
    @content = @access_token.get("http://api.freelancer.com/Project/searchProjects.json?searchjobtypecsv=#{params[:jobtype]}")
    render :json => @content.body
  end


  def getProjectDetails
    @content = @access_token.get("http://api.freelancer.com/Project/getProjectDetails.json?projectid=5739955")
    render :json => @content.body
  end

  def storeProjectsDetails
    @content = @access_token.get("http://api.freelancer.com/Project/searchProjects.json?searchjobtypecsv=#{params[:jobtype]}")
    hash = JSON.parse @content.body
    skip = 0
    hash['json-result']['items'].each do |ele, index|
      @projectid = ele['projectid']
      @content = @access_token.get("http://api.freelancer.com/Project/getProjectDetails.json?projectid=#{@projectid}")
      h = JSON.parse(@content.body)['json-result']
      begin
        Project.create do |project|
          project.outside_id = h['id']
          project.name = h['name']
          project.url = h['url']
          project.budget = "#{h['budget']['min']}, #{h['budget']['max']}"
          project.require_skills = "#{h['jobs'].join(", ")}"
          project.from_source = 'freelancer'
          project.description = h['short_descr']
          project.project_category = h['jobsDetails'][0]['category_id']
          project.currency = h['currency']
          project.start_date = h['start_date']
          project.end_date = h['end_date']
          project.currency_code = h['currencyDetails']['code']
          project.currency_exchangerate = h['currencyDetails']['exchangerate']
        end
      rescue
        skip += 1
      end
      puts "http://api.freelancer.com/Project/getPublicMessages.json?projectid=#{ele['projectid']}"
      @content = @access_token.get("http://api.freelancer.com/Project/getPublicMessages.json?projectid=#{ele['projectid']}")
      public_message = JSON.parse(@content.body)['json-result']
      puts public_message
      if public_message['count'] > 0
        public_message['items'].each do |ele, index|
          ProjectPublicMessage.create do |m|
            m.project_id = @projectid
            m.from_user_name = ele['fromusername']
            m.from_user_id = ele['fromuserid']
            m.datetime = ele['datetime']
            m.text = ele['text']
            m.attachmentlink = ele['attachmentlink']
          end
        end
      end
    end
    render :json => { :status => "success", :skip => skip}
  end

  def getCategoryJobList
    @access_token = construct_access_token()
    @content = @access_token.get("http://api.freelancer.com/Job/getCategoryJobList.json")
    # hash = JSON.parse @content.body
    # hash['json-result']['items']['category'].each do |ele, index|
    # puts "#{ele['id']}, #{ele['name']}"
    # project_category = ProjectCategory.create( :id => ele['id'], :name => ele['name'])
    # end
    render :json => @content.body
  end

  def getPublicMessages()
    request_url = "http://api.freelancer.com/Project/getPublicMessages.json?projectid=#{params[:project_id]}"
    @content = @access_token.get(request_url)
    render :json => JSON.parse(@content.body)['json-result']
  end



  def wirte_job_to_csv
    @projects = Project.order(:id)
    respond_to do |format|
      format.html
      format.csv { send_data @projects.to_csv, :type => "application/csv", :filename => "project_list.csv" }
      format.xls { send_data @projects.to_csv(col_sep: "\t") }
    end
  end

  def excel_download
    @projects = Project.order(:id)
    respond_to do |format|
      format.html
      format.xls
    end
  end

  def set_word_count
    @projects = Project.order(:id)
    @projects.each do |p|
      name_word_count = p.name.gsub(/[(,) ]/," ").split(/ /).delete_if {|item| item == '' }
      description_word_count = p.description.gsub(/[(,) ]/," ").split(/ /).delete_if {|item| item == '' }
      p.word_count = name_word_count.length + description_word_count.length
      p.save
    end
    render :json => { :name_count => "123", :data => @temp }
  end


end
