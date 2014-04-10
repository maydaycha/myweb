require 'json'

class OdesksController < ApplicationController
  before_action :get_access_token

  def get_access_token
    @access_token = Oauth.construct_access_token('odesk')
  end

  def search_jobs
    @content = @access_token.get('https://www.odesk.com/api/profiles/v2/search/jobs.json?q=python')
    render :json => @content.body
  end


  def index
  end



end
