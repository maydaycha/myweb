module API
	module V1
		class Snapshot < Grape::API
			version 'v1'
			format :json

			helpers do
				def current_history(user, projectID)
					if history = user.working_histories.find_by_project_id(projectID)
						history
					else
						history = user.working_histories.create!(project_id: projectID)
					end
				end
			end

			namespace :UploadSnapshot do
				desc "Return list of projects", {
					
					notes: 'Login and Generate auth token for user'
				}
				params do
					requires :email, type: String, desc: "Email"
					requires :sessionToken, type: String, desc: "SessionToken"
					requires :projectID, type: Integer
					requires :mouseClickCount, type: Integer
					requires :keyboardClickCount, type: Integer
					requires :snapshot, type: String
				end
				
				post do
					user = User.find_by(email: params[:email])
					if user && user.ensure_authentication_token === params[:sessionToken]
						snapshot = user.snapshots.create!(project_id: params[:projectID], 
																							mouseClickCount: params[:mouseClickCount],
																							keyboardClickCount: params[:keyboardClickCount],
																							snapshot: params[:snapshot])

						history = current_history(user, params[:projectID])
						# To-Do : it should reset the mouseClick and keyboardClick when start a new working day
						# if (Time.now).day != (history.day_start_count_at).day
						# 	history.day_start_count_at = Time.now
						# 	history.mouseClick = 0
						# 	history.keyboardClick = 0
						# 	history.todayWorkingHours = 0
						# end

						# To-Do : it should reset the weekWorkingHours when start a new working week
						

						m = history.mouseClick + params[:mouseClickCount]
						k = history.keyboardClick + params[:keyboardClickCount]
						history.update!(mouseClick: m, 
														keyboardClick: k)
						present :status, "OK"
						present :message, ""
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


