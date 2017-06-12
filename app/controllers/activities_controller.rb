class ActivitiesController < ApplicationController
	before_action :authenticate_user!
	before_action :admin_user

	def index
		@activities = Activity.by_date
	end
end
