require 'oauth_token'
require 'json'
require "csv"

class ProjectsController < ApplicationController
  include Token

  before_filter :set_headers

  def index
    @projects = Project.all
    @category = ProjectCategory.all
    respond_to do |format|
      format.html { render :html => [ @projects, @category ] }
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
    <<<<<<< HEAD
=======
      # redirect_to :action => :show, :id => @project
      >>>>>>> b2ef7ccd4a8c62b121043b5846717d269b5b9922
    redirect_to project_path(@project)
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path
  end

  def get_project_by_translator
    puts session[:account]
    if session[:account]
      @translator = Translator.find_by_account(session[:account])
      if @translator
        @projects = Project.where(:translators => @translator['id'])
        if @projects
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
    @access_token = construct_access_token()
    @content = @access_token.get("http://api.freelancer.com/Project/searchProjects.json?searchjobtypecsv=#{params[:jobtype]}")
    render :json => @content.body
  end


  def getProjectDetails
    @access_token = construct_access_token()
    <<<<<<< HEAD
    @content = @access_token.get("http://api.freelancer.com/Project/getProjectDetails.json?projectid=5739955")
=======
      @content = @access_token.get("http://api.freelancer.com/Project/getProjectDetails.json?projectid=5735881")
    >>>>>>> b2ef7ccd4a8c62b121043b5846717d269b5b9922
    render :json => @content.body
  end

  def storeProjectsDetails
    @access_token = construct_access_token()
    @content = @access_token.get("http://api.freelancer.com/Project/searchProjects.json?searchjobtypecsv=#{params[:jobtype]}")
    hash = JSON.parse @content.body
    skip = 0
    hash['json-result']['items'].each do |ele, index|
      @content = @access_token.get("http://api.freelancer.com/Project/getProjectDetails.json?projectid=#{ele['projectid']}")
      hash2 = JSON.parse @content.body
      h = hash2['json-result']
      begin
        project = Project.create( :outside_id => h['id'], :name => h['name'], :url => h['url'], :budget => "#{h['budget']['min']},#{h['budget']['max']}", :require_skills => "#{h['jobs'].join(", ")}", :from_source => 'freelancer', :description => h['short_descr'], :project_category => h['jobsDetails'][0]['category_id'], :currency => h['currency'], :start_date => h['start_date'], :end_date => h['end_date'], :currency_code => h['currencyDetails']['code'], :currency_exchangerate => h['currencyDetails']['exchangerate'] )
      rescue
        skip += 1
      end
    end
    render :json => { :status => "success", :skip => skip }
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



end
