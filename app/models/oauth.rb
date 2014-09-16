# encoding: UTF-8
class Oauth < ActiveRecord::Base

  def self.construct_access_token(source)
    puts source
    case source
    when 'freelancer'
      consumer_key = "51c2ea4b1c33af8b30ae432f1c54916ef8cd6067"
      consumer_secret = "f0f94b06fc598df4a8f2a13fdf77997457a80810"
      request_token_path = "http://api.freelancer.com/RequestRequestToken/requestRequestToken.json"
      access_token_path = "http://api.freelancer.com/RequestAccessToken/requestAccessToken.json"
      authorize_path = "http://www.freelancer.com/users/api-token/auth.php"
      http_method = 'get'
    when 'odesk'
      consumer_key = '320374890bf12ae1c6ff5fcb8e2c55dd'
      consumer_secret = '16236f39513ce2ca'
      request_token_path = "https://www.odesk.com/api/auth/v1/oauth/token/request"
      authorize_path = 'https://www.odesk.com/services/api/auth'
      access_token_path = 'https://www.odesk.com/api/auth/v1/oauth/token/access'
      http_method = 'get'
    end

    @consumer = OAuth::Consumer.new( consumer_key, consumer_secret, {
                                       :request_token_path => request_token_path,
                                       :access_token_path  => access_token_path,
                                       :authorize_path     => authorize_path,
                                       :scheme => :query_string,
                                       :http_method => http_method
    })
    @user = Oauth.where( name: 'maydaycha', source: source).first
    @access_token = OAuth::AccessToken.new(@consumer, @user['token'], @user['secret'])
  end

end
