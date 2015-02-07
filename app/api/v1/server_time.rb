module API
	module V1
		class ServerTime < Grape::API
			version 'v1'
			format :json

			namespace :server_time do
				desc "Return server time to app", {
					
					notes: 'Get server time for authenticated user'
				}
				params do
					requires :email, type: String, desc: "Email"
					requires :sessionToken, type: String
				end
				get do
					user = User.find_by(email: params[:email])
					if user && user.ensure_authentication_token === params[:sessionToken]
						present :status, "OK"
						present :message, "server time"
						present :timestamp, Time.now.to_i
					else
						present :status, "Not OK"
						present :message, "??"
					end
				end

			end
		end

	end
end
