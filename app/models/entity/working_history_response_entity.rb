module Entity
	class WorkingHistoryResponseEntity < Grape::Entity
		expose :mouseClick
		expose :keyboardClick
		expose :lastWorkingTimestamp
		expose :todayWorkingHours
		expose :weekWorkingHours
	end
end

