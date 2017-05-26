module PropertiesHelper
	def status(property)
		if Date.today <= property.start_date
			return "upcoming"
		elsif Date.today <= property.end_date
			return "started"
		else
			return "ended"
		end
	end
end
