module Entity
	class LoginResponseEntity < Grape::Entity
		expose :username
		expose :authentication_token
	end
end