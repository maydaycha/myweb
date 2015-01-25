module API
	module V1
		class Login < Grape::API
			version 'v1'
			format :json

			namespace :login do
				desc "Return list of projects", {
					
					notes: 'Login and Generate auth token for user'
				}
				params do
					requires :email, type: String, desc: "Email"
					requires :password, type: String, desc: "Password"
					requires :timeZone, type: time, des:  "localtime"
				end
				
				post do
					user = User.find_by(email: params[:email])	
					if user && user.valid_password?(params[:password])
						user.ensure_authentication_token
						present :status, "OK"
						present :message, ""
						present :employer, "?"
						present :user, user, :with => Entity::LoginResponseEntity
					else
						error! 'Unauthorized, invalid password email', 401
					end

				end

			end
		end

	end
end