class ActivitiesController < ApplicationController
	def index
		@activities = Activity.by_date
	end
end
