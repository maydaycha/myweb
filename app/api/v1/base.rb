module API
	module V1
		class Base < Grape::API
			mount API::V1::ProjectList
			mount API::V1::Login
			mount API::V1::ServerTime
			mount API::V1::Memo
			mount API::V1::Snapshot
			mount API::V1::WorkingStatus
			mount API::V1::WorkingHistory
		end
	end
end