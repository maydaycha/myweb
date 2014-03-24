require 'oauth_token'

class ApiController < ApplicationController
    include Token

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
end
