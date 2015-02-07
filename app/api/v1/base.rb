module API
	module V1
		class Base < Grape::API
			mount API::V1::ProjectList
			mount API::V1::Login
			mount API::V1::ServerTime
			mount API::V1::Memo
			mount API::V1::Snapshot
		end
	end
end