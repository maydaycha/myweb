module Entity
	class MemoResponseEntity < Grape::Entity
		expose :id
		expose :memoContent
	end
end