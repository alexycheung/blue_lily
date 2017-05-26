module PropertiesHelper
	def status(property)
		if DateTime.now < property.start_date
			return "upcoming"
		elsif DateTime.now < property.end_date
			return "started"
		else
			return "ended"
		end
	end
end
