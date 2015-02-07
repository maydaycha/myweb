module API
	module V1
		class ProjectList < Grape::API
			version 'v1'
			format :json

			namespace :project_list do
				desc "Return list of projects", {
					entity: Entity::ProjectResponseEntity,
					notes: 'Get all projects for authenticated user'
				}
				params do
					requires :email, type: String, desc: "Email"
					requires :sessionToken, type: String
				end

				post do
					user = User.find_by(email: params[:email])
					if user && user.ensure_authentication_token === params[:sessionToken]
						projects = Project.all
						present :status, "OK"
						present :message, "hello"
						present :projects, projects, :with => Entity::ProjectResponseEntity
					else
						error! 'Unauthorized, expire token. Please login again', 401
					end
				end

			end
		end

	end
end