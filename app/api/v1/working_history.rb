module API
	module V1
		class WorkingStatus < Grape::API
			version 'v1'
			format :json

			namespace :working_status do
				desc "Return list of projects", {
					
					notes: 'Get all projects for authenticated user'
				}
				params do
					requires :email, type: String, desc: "Email"
					# requires :sessionToken, type: String, desc: "SessionToken"
					requires :timestamp, type: integer
					requires :projectID, type: integer
				end

				get do
					# Update working status process
					present :status, "OK"
					present :message, ""

					#present :working_history, working_history
				end

			end
		end

	end
end