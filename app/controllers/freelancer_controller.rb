require 'oauth_token'
require 'json'

class FreelancerController < ApplicationController
  include Token

  before_filter :get_access_token
  before_filter :set_headers

  def get_access_token
    @access_token = construct_access_token
  end

  def getUsersBySearch
    @access_token = construct_access_token()
    @content = @access_token.get('http://api.freelancer.com/User/getUserDetails.json?username=LibraMa')
    puts "test"
    render :json => @content.body
  end

  def getAccountDetails
    @access_token = construct_access_token()
    @content = @access_token.get('http://api.freelancer.com/Profile/getAccountDetails.json')
    render :json => @content.body
  end

  def searchProjects
    content = @access_token.get("http://api.freelancer.com/Project/searchProjects.json?searchjobtypecsv=#{params[:jobtype]}")
    render :json => content.body
  end

  def getProjectDetails
    content = @access_token.get("http://api.freelancer.com/Project/getProjectDetails.json?projectid=5739955")
    render :json => content.body
  end

  def storeProjectsDetails
    content = @access_token.get("http://api.freelancer.com/Project/searchProjects.json?searchjobtypecsv=#{params[:jobtype]}")
    hash = JSON.parse content.body
    skip = 0
    hash['json-result']['items'].each do |ele, index|
      @projectid = ele['projectid']
      content = @access_token.get("http://api.freelancer.com/Project/getProjectDetails.json?projectid=#{@projectid}")
      h = JSON.parse(content.body)['json-result']
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
      content = @access_token.get("http://api.freelancer.com/Project/getPublicMessages.json?projectid=#{ele['projectid']}")
      public_message = JSON.parse(content.body)['json-result']
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
    content = @access_token.get("http://api.freelancer.com/Job/getCategoryJobList.json")
    hash = JSON.parse content.body
    hash['json-result']['items']['category'].each do |ele, index|
    puts "#{ele['id']}, #{ele['name']}"
    project_category = ProjectCategory.create( :id => ele['id'], :name => ele['name'])
    end
    render :json => content.body
  end

  def getPublicMessages()
    request_url = "http://api.freelancer.com/Project/getPublicMessages.json?projectid=#{params[:project_id]}"
    content = @access_token.get(request_url)
    render :json => JSON.parse(content.body)['json-result']
  end


end
