module API
	module V1
		class WorkingStatus < Grape::API


			version 'v1'
			format :json

			helpers do
				def current_history(user, projectID)
					if history = user.working_histories.find_by_project_id(projectID)
						history
					else
						history = user.working_histories.create!({project_id: params[:projectID]})
					end
				end
			end

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

				put do
					user = User.find_by(email: params[:email])
					if user && user.ensure_authentication_token === params[:sessionToken]
						history = current_history(user, params[:projectID])

						if params[:workingStatus] == "STOP"
							WorkingHours = history.todayWorkingHours + (Time.now - history.work_start_at)
							history.update!(todayWorkingHours: WorkingHours)
							present :status, "OK"
							present :message, "Stop Working at #{Time.now}, work: #{WorkingHours.strftime("%H:%M:%S")}"
						end
						if params[:workingStatus] == "START"
							history.update!(project_id: params[:projectID], 
															lastWorkingTimestamp: Time.now.to_i, 
															work_start_at: Time.now)
							present :status, "OK"
							present :message, "Start Working at #{Time.now}"
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
