module API
	module V1
		class WorkingHistory < Grape::API
			version 'v1'
			format :json

			namespace :GetWorkingHistory do
				desc "Return working history ", {
					
					notes: 'Get working history for authenticated user'
				}
				params do
					requires :email, type: String, desc: "Email"
					requires :sessionToken, type: String
					requires :projectID, type: Integer
				end

				get do
					user = User.find_by(email: params[:email])
					if user && user.ensure_authentication_token === params[:sessionToken]
						history = user.working_histories.find_by_project_id(params[:projectID])
						present :status, "OK"
						present :message, ""
						present :history, history, :with => Entity::WorkingHistoryResponseEntity
					else
						present :status, "Not OK"
						present :message, "?"
					end

					#present :working_history, working_history
				end

			end
		end

	end
end