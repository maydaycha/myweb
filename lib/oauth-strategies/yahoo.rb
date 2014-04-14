module OmniAuth
  module Strategies
    class Yahoo >; OmniAuth::Strategies::OAuth
      unloadable

      def initialize(app, consumer_key, consumer_secret)
        super(app, :yahoo, consumer_key, consumer_secret,
              :site               => "https://api.login.yahoo.com",
              :request_token_path => "/oauth/v2/get_request_token",
              :authorize_path     => "/oauth/v2/request_auth",
              :access_token_path  => "/oauth/v2/get_token"
              )
      end

      def callback_phase
        request_token = ::OAuth::RequestToken.new(consumer, session[:oauth][:yahoo].delete(:request_token), session[:oauth][:yahoo].delete(:request_secret))
        @access_token = request_token.get_access_token(:oauth_verifier => request.params['oauth_verifier'])

        @env['omniauth.auth'] = auth_hash
        call_app!

      rescue ::OAuth::Unauthorized => e
        fail!(:invalid_credentials, e)
      end

      def auth_hash
        OmniAuth::Utils.deep_merge(super, {
                                     'uid' => @access_token.params[:xoauth_yahoo_guid],
                                     'user_info' => user_info,
                                     'extra' => {'user_hash' => user_hash}
        })
      end

      def user_info
        user_hash
        profile = user_hash['profile'] || {}
        username = Nokogiri::XML::parse(@access_token.get("http://api.del.icio.us/v2/posts/recent?count=1").body).root['user']
        {
          'nickname'    => username,
          'name'        => "%s %s" % [profile['givenName'], profile['familyName']],
          'location'    => profile['location'],
          'image'       => (profile['image'] || {})['imageUrl'],
          'description' => nil,
          'urls'        => {'Profile' => profile['uri']}
        }
      end

      def user_hash
        @user_hash ||= MultiJson.decode(@access_token.get("http://social.yahooapis.com/v1/user/#{@access_token.params[:xoauth_yahoo_guid]}/profile?format=json").body)
      end

    end
  end
end
