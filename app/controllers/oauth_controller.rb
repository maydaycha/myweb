class OauthController < ApplicationController
  def index
  end

  def oauth_process
    consumer_key = "51c2ea4b1c33af8b30ae432f1c54916ef8cd6067"
    consumer_secret = "f0f94b06fc598df4a8f2a13fdf77997457a80810"
    callback_url = "http://#{request.host}:#{request.port}/oauth/get_access_token?"
    request_token_path = "http://api.freelancer.com/RequestRequestToken/requestRequestToken.json"
    access_token_path = "http://api.freelancer.com/RequestAccessToken/requestAccessToken.json"
    authorize_path = "http://www.freelancer.com/users/api-token/auth.php"
    @consumer = OAuth::Consumer.new( consumer_key, consumer_secret,
                                     # :site=>"http://api.freelancer.com",
                                     :request_token_path => request_token_path,
                                     :access_token_path  => access_token_path,
                                     :authorize_path     => authorize_path,
                                     :scheme => :query_string,
                                     :http_method => :get
                                     )
    @request_token = @consumer.get_request_token(:oauth_callback => callback_url)
    session[:request_token] = @request_token
    # print @request_token.inspect
    redirect_to @request_token.authorize_url
  end

  def get_access_token
    if @oauth_verifier = params[:oauth_verifier]
      @request_token = session[:request_token]
      @access_token = @request_token.get_access_token(:oauth_verifier => @oauth_verifier)
      @content = @access_token.get('http://api.freelancer.com/Profile/getAccountDetails.json')
      render :json => @content.body
      user = Oauth.create( :name => 'maydaycha', :token => @access_token.token, :secret => @access_token.secret)
    else
      redirect_to 'request.original_url'
    end
  end

  def construct_access_token
    consumer_key = "51c2ea4b1c33af8b30ae432f1c54916ef8cd6067"
    consumer_secret = "f0f94b06fc598df4a8f2a13fdf77997457a80810"
    callback_url = 'http://0.0.0.0:3000/get_access_token?'
    @consumer = OAuth::Consumer.new( consumer_key, consumer_secret, {
                                       :request_token_path => request_token_path,
                                       :access_token_path  => access_token_path,
                                       :authorize_path     => authorize_path,
                                       :scheme => :query_string,
                                       :http_method => :get
    })
    @user = Oauth.where( :name => 'maydaycha').first
    @access_token = OAuth::AccessToken.new(@consumer, @user['token'], @user['secret'])

  end
end
