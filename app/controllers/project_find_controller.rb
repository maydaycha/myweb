class ProjectFindController < ApplicationController
	protect_from_forgery except: [:add_to_favorite, :remove_from_favorite]
	before_action :set_headers
	before_action :authenticate_user!

	def freelencer_find
	end
end
