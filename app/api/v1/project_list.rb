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
					# requires :sessionToken, type: String, desc: "SessionToken"
				end

				post do
					projects = Project.all
					present :status, "OK"
					present :message, "hello"
					present :projects, projects, :with => Entity::ProjectResponseEntity
				end

			end
		end

	end
end