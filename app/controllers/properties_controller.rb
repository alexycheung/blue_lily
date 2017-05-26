class PropertiesController < ApplicationController
	def index
		@properties = Property.by_start_date
	end
end
