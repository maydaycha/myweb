module Entity
	class ProjectResponseEntity < Grape::Entity
		expose :id
		expose :name
		expose :worked_hours
	end
end