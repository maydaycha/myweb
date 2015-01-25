module API
	module V1
		class ServerTime < Grape::API
			version 'v1'
			format :json

			namespace :server_time do
				desc "Return server time to app", {
					
					notes: 'Get all projects for authenticated user'
				}
				get do
					present :status, "OK"
					present :message, "server time"
					present :timestamp, Time.now.to_i
				end

			end
		end

	end
end