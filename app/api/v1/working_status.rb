module API
	module V1
		class WorkingStatus < Grape::API
			require 'active_record'

			version 'v1'
			format :json

			namespace :UpdateWorkingStatus do
				desc "Update workging status", {
					
					notes: 'Update workging status'
				}
				params do
					requires :email, type: String, desc: "Email"
					requires :sessionToken, type: String
					requires :timestamp, type: Integer
					requires :projectID, type: Integer
					requires :workingStatus, type: String
				end

				post do
					user = User.find_by(email: params[:email])
					if user && user.ensure_authentication_token === params[:sessionToken]
						history = user.working_histories.where(project_id: params[:projectID])
						if params[:workingStatus] == "STOP"
							history.todayWorkingHours += Time.now - Time.at(history.lastWorkingTimestamp)
							present :status, "OK"
							present :message, ""
						end
						if params[:workingStatus] == "START"
							user.working_histories.where(project_id: params[:projectID]).update({
          		project_id: params[:projectID]
        			})
							present :status, "OK"
							present :message, "start at #{Time.now}"
						end

						
					else
						error! 'Upload fialed', 401
						present :status, "Not OK"
						present :message, "upload failed"
					end
				end

			end
		end

	end
end
