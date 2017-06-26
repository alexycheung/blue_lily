class VersionsController < ApplicationController
	before_action :authenticate_user!
	before_action :admin_user
	before_action :super_admin_user

	def index
		@versions = Version.by_date.page params[:page]
	end

	def undo
		@version = Version.find(params[:id])
		@version.undo
		@version.undo_at = DateTime.now
		@version.save
		respond_to do |format|
			format.js
		end
	end
end
