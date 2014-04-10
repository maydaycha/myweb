class OauthController < ApplicationController
  def index
  end

  def oauth_start
    case params[:source]
    when 'freelancer'
      consumer_key = "51c2ea4b1c33af8b30ae432f1c54916ef8cd6067"
      consumer_secret = "f0f94b06fc598df4a8f2a13fdf77997457a80810"
      callback_url = "http://#{request.host}:#{request.port}/get_access_token/freelancer?"
      request_token_path = "http://api.freelancer.com/RequestRequestToken/requestRequestToken.json"
      access_token_path = "http://api.freelancer.com/RequestAccessToken/requestAccessToken.json"
      authorize_path = "http://www.freelancer.com/users/api-token/auth.php"
      http_method = 'get'
    when 'odesk'
      consumer_key = '320374890bf12ae1c6ff5fcb8e2c55dd'
      consumer_secret = '16236f39513ce2ca'
      callback_url = "http://#{request.host}:#{request.port}/get_access_token/odesk?"
      request_token_path = "https://www.odesk.com/api/auth/v1/oauth/token/request"
      authorize_path = 'https://www.odesk.com/services/api/auth'
      access_token_path = 'https://www.odesk.com/api/auth/v1/oauth/token/access'
      http_method = 'post'
    else
    end
    @consumer = OAuth::Consumer.new( consumer_key, consumer_secret,
                                     :request_token_path => request_token_path,
                                     :access_token_path  => access_token_path,
                                     :authorize_path     => authorize_path,
                                     :scheme => :query_string,
                                     :http_method => http_method
                                     )

    # return render :json => { source: @consumer }

    @request_token = @consumer.get_request_token(:oauth_callback => callback_url)
    session[:request_token] = @request_token
    # print @request_token.inspect
    redirect_to @request_token.authorize_url
  end

  def get_access_token
    if @oauth_verifier = params[:oauth_verifier]
      @request_token = session[:request_token]
      @access_token = @request_token.get_access_token(:oauth_verifier => @oauth_verifier)

      case params[:source]
      when 'freelancer'
        @content = @access_token.get('http://api.freelancer.com/Profile/getAccountDetails.json')
      when 'odesk'
        @content = @access_token.get('https://www.odesk.com/api/hr/v2/users/me.json')
      end

      user = Oauth.create( name: 'maydaycha', token: @access_token.token, secret: @access_token.secret, source: params[:source] )
      render :json => @content.body
    else
      redirect_to request.original_url
    end
  end


end
