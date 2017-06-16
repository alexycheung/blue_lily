module PropertiesHelper
	def status(property)
		if !property.start_date || !property.end_date
			return nil
		elsif Date.today <= property.start_date
			return "upcoming"
		elsif Date.today <= property.end_date
			return "started"
		else
			return "ended"
		end
	end

	# Return payment photo or camera icon
	def property_payment(property)
		if property.payment
			return "#{filepicker_image_tag property.payment, fit: 'crop', w: 200, h: 200}"
		else
			return "#{fa_icon 'camera'}"
		end
	end
end
