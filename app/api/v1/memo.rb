module API
	module V1
		class Memo < Grape::API
			version 'v1'
			format :json

			namespace :memoGet do
				desc "Return list of memos", {
					
					notes: 'Get memos for authenticated user'
				}
				params do
					requires :email, type: String, desc: "Email"
					requires :sessionToken, type: String
					requires :projectID, type: Integer
				end

				get do
					# Update working status process
					user = User.find_by(email: params[:email])
					if user && user.ensure_authentication_token === params[:sessionToken]
						memos = user.memos
						present :status, "OK"
						present :message, ""
						present :memos, memos, :with => Entity::MemoResponseEntity
					else
						present :status, "Not OK"
						present :message, "??"
					end
				end
			end

			namespace :memoCreate do
				desc "Create memos", {
					
					notes: 'Create memos for authenticated user'
				}
				params do
					requires :email, type: String, desc: "Email"
					requires :sessionToken, type: String
					requires :projectID, type: Integer
					requires :memoContent, type: String
				end

				post do
					# Update working status process
					user = User.find_by(email: params[:email])
					if user && user.ensure_authentication_token === params[:sessionToken]
						memo = user.memos.create!({memoContent: params[:memoContent], project_id: params[:projectID]})
						present :status, "OK"
						present :message, ""
					else
						present :status, "Not OK"
						present :message, "?"
					end
				end
			end


			namespace :memoUpdate do
				desc "Update memos", {
					
					notes: 'Update memos for authenticated user'
				}
				params do
					requires :email, type: String, desc: "Email"
					requires :sessionToken, type: String
					requires :memoID, type: Integer
					requires :memoContent, type: String
				end

				put do
					# Update working status process
					user = User.find_by(email: params[:email])
					memo = Memo.find_by(id: "1")
					if user && user.ensure_authentication_token === params[:sessionToken]
						# memo = Memo.find_by(id: "1")
						# memo = user.memos.update!({memoContent: params[:memoContent], project_id: params[:projectID]})
						present :status, "OK"
						present :message, ""
					else
						present :status, "Not OK"
						present :message, "?"
					end
				end
			end
		end

	end
end
