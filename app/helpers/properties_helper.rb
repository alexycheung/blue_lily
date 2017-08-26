module PropertiesHelper
	def status(property)
		if !property.start_date || !property.end_date
			return nil
		elsif Date.today <= property.start_date
			return "pending"
		elsif Date.today <= property.end_date
			return "open"
		else
			return "closed"
		end
	end

	# Return payment photo or camera icon
	def property_payment(property)
		if property.payment && property.payment != ""
			return "#{filepicker_image_tag property.payment, fit: 'crop', w: 200, h: 200}"
		else
			return "#{fa_icon 'camera'}"
		end
	end

	# Return contract photo or camera icon
	def property_contract(property)
		if property.contract && property.contract != ""
			return "#{filepicker_image_tag property.contract, fit: 'crop', w: 200, h: 200}"
		else
			return "#{fa_icon 'camera'}"
		end
	end
end
