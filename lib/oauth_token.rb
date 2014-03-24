module Token
    def construct_access_token
        consumer_key = "51c2ea4b1c33af8b30ae432f1c54916ef8cd6067"
        consumer_secret = "f0f94b06fc598df4a8f2a13fdf77997457a80810"
        callback_url = 'http://0.0.0.0:3000/get_access_token?'
        @consumer = OAuth::Consumer.new( consumer_key, consumer_secret, {
            :request_token_path => "http://api.freelancer.com/RequestRequestToken/requestRequestToken.json",
            :access_token_path  => "http://api.freelancer.com/RequestAccessToken/requestAccessToken.json",
            :authorize_path     => "http://www.freelancer.com/users/api-token/auth.php",
            :scheme => :query_string,
            :http_method => :get
            })
        @user = Oauth.where( :name => 'maydaycha').first
        @access_token = OAuth::AccessToken.new(@consumer, @user['token'], @user['secret'])
        # if @user
            # @token = OAuth::AccessToken.new(@user['token'], @user['secret'])
            # puts @token.inspect
            # puts @user.inspect
            # puts @token
            # @content = @access_token.get('http://api.freelancer.com/User/getUserDetails.json?username=LibraMa')
            # render :json => @content.body
        # else
            # render :json => { :status => "fail" }
        # end
    end
end
