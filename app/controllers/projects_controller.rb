require 'oauth_token'
require 'json'

class ProjectsController < ApplicationController
    include Token

    def index
        @projects = Project.all
    end

    def show
        @project = Project.find(params[:id])
    end

    def edit
        @project = Project.find(params[:id])
    end

    def update
        @project = Project.find(params[:id])
        @project.update(params.permit![:project])
        # redirect_to project_path(@project)
        redirect_to :action => :show, :id => @project
    end

    def searchProjects
        @access_token = construct_access_token()
        @content = @access_token.get("http://api.freelancer.com/Project/searchProjects.json?searchjobtypecsv=#{params[:jobtype]}")
        render :json => @content.body
    end

    def storeProjects
        @access_token = construct_access_token()
        @content = @access_token.get("http://api.freelancer.com/Project/searchProjects.json?searchjobtypecsv=#{params[:jobtype]}")
        hash = JSON.parse @content.body
        # puts hash['json-result']['']
        hash['json-result']['items'].each do |ele, index|
            project = Project.create( :outside_id => ele['projectid'], :name => ele['projectname'], :url => ele['projecturl'], :budget => ele['bids'], :require_skills => ele['jobtypecsv'], :remain_time => ele['startdate'], :duration => ele['startdate'], :from_source => 'freelancer', :description => ele['projecturl'])
        end
        render :json => @content.body
    end

    def getProjectDetails
     @access_token = construct_access_token()
     @content = @access_token.get("http://api.freelancer.com/Project/getProjectDetails.json?projectid=5707818")
     render :json => @content.body
 end

 def storeProjectsDetails
    @access_token = construct_access_token()
    @content = @access_token.get("http://api.freelancer.com/Project/searchProjects.json?searchjobtypecsv=#{params[:jobtype]}")
    hash = JSON.parse @content.body
        # puts hash['json-result']['']
        hash['json-result']['items'].each do |ele, index|
            @content = @access_token.get("http://api.freelancer.com/Project/getProjectDetails.json?projectid=#{ele['projectid']}")
            hash2 = JSON.parse @content.body
            hash2 = hash2['json-result']
            project = Project.create( :outside_id => hash2['id'], :name => hash2['name'], :url => hash2['url'], :budget => "#{hash2['budget']['min']},#{hash2['budget']['max']}", :require_skills => "#{hash2['jobs'].join(", ")}", :remain_time => hash2['end_date'], :duration => hash2['end_date'], :from_source => 'freelancer', :description => hash2['short_descr'])
        end
        render :json => @content.body
    end
end
