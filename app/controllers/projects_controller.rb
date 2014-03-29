require 'oauth_token'
require 'json'

class ProjectsController < ApplicationController
    include Token

    before_filter :set_headers

    def index
        @projects = Project.all
        respond_to do |format|
            format.html # index.html.erb
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
        # redirect_to :action => :show, :id => @project
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
       @content = @access_token.get("http://api.freelancer.com/Project/getProjectDetails.json?projectid=5709251")
       render :json => @content.body
   end

   def storeProjectsDetails
    @access_token = construct_access_token()
    @content = @access_token.get("http://api.freelancer.com/Project/searchProjects.json?searchjobtypecsv=#{params[:jobtype]}")
    hash = JSON.parse @content.body
    hash['json-result']['items'].each do |ele, index|
        @content = @access_token.get("http://api.freelancer.com/Project/getProjectDetails.json?projectid=#{ele['projectid']}")
        hash2 = JSON.parse @content.body
        hash2 = hash2['json-result']
        project = Project.create( :outside_id => hash2['id'], :name => hash2['name'], :url => hash2['url'], :budget => "#{hash2['budget']['min']},#{hash2['budget']['max']}", :require_skills => "#{hash2['jobs'].join(", ")}", :remain_time => hash2['end_date'], :duration => hash2['end_date'], :from_source => 'freelancer', :description => hash2['short_descr'], :project_category => hash2['jobsDetails'][0]['category_id'])
    end
    render :json => @content.body
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
end
