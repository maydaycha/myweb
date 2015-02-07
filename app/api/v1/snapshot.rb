module API
	module V1
		class Snapshot < Grape::API
			version 'v1'
			format :json

			namespace :UploadSnapshot do
				desc "Return list of projects", {
					
					notes: 'Login and Generate auth token for user'
				}
				params do
					requires :email, type: String, desc: "Email"
					requires :sessionToken, type: String, desc: "SessionToken"
					requires :projectsID, type: Integer
					requires :mouseClickCount, type: Integer
					requires :keyboardClickCount, type: Integer
					requires :snapshot, type: String
				end
				
				post do
					user = User.find_by(email: params[:email])
					if user && user.ensure_authentication_token === params[:sessionToken]
						snapshot = user.snapshots.create!({project_id: params[:projectID], 
																							mouseClickCount: params[:mouseClickCount],
																							keyboardClickCount: params[:keyboardClickCount],
																							snapshot: params[:snapshot]})
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


