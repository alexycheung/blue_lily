module ItemsHelper
	# Return item photo or camera icon
	def item_photo(item)
		if item.photo
			return "#{filepicker_image_tag item.photo, fit: 'crop', w: 187, h: 187}"
		else
			return "#{fa_icon 'camera'}"
		end
	end

	# Return status for when item will be available
	def item_status(item)
		reservations = item.reservations
		reservations.each do |reservation|
			booked = reservation.checkout && !reservation.checkin
			if booked
				end_date = reservation.property.end_date
				days = TimeDifference.between(Time.now, end_date).in_days.to_i
				if end_date > Time.now
					return "booked #{pluralize(days, 'day')}"
				else
					return "late #{pluralize(days, 'day')}"
				end
			end
		end
		return "available"
	end
end