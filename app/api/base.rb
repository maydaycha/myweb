module API
	class Base < Grape::API
		version 'v1'
		format :json

		# before do
  #     error!("401 Unauthorized", 401) unless authenticated
  #   end

  #   helpers do
  #   	def warden
  #   		env['warden']
  #   	end

  #   	def authenticated
  #   		return true if warden.authenticated?
  #   		params[:access_token] && @user = User.find_by_authentication_token(params[:access_token])
  #   	end

  #   	def current_user
  #   		warden.user || @user
  #   	end
  #   end

		mount API::V1::Base
	end
end