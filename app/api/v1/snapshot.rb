module API
	module V1
		class Snapshot < Grape::API
			version 'v1'
			format :json

			namespace :snapshot do
				desc "Return list of projects", {
					
					notes: 'Login and Generate auth token for user'
				}
				params do
					requires :email, type: String, desc: "Email"
					requires :sessionToken, type: String, desc: "SessionToken"
					requires :projectsID, type: integer
					requires :mouseClickCount, type: integer
					requires :keyboardClickCount, type: integer
					requires :snapshot
				end
				
				post do
					user = User.find_by(email: params[:email])
					if if user && user.ensure_authentication_token === params[:sessionToken]
						user.ensure_authentication_token
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