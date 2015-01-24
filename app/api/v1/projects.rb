module API
	module V1
		class Projects < Grape::API
			version 'v1'
			format :json

			namespace :projects do
				desc "Return list of projects", {
					entity: Entity::ProjectResponseEntity
					notes: 'Get all projects for authenticated user'
				}
				get do
					projects = Project.all
					present projects, :with => Entity::ProjectResponseEntity
				end

			end
		end

	end
end