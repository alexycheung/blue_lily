module UnitsHelper
	# Return status for when item will be available
	def unit_status(unit)
		reservations = unit.reservations
		reservations.each do |reservation|
			if booked = reservation.checkout && !reservation.checkin
				end_date = reservation.property.end_date
				days = TimeDifference.between(Time.now, end_date).in_days.to_i
				if end_date > Time.now
					return "booked #{pluralize(days, 'day')}"
				else
					return "late #{pluralize(days, 'day')}"
				end
			else
				reserved = !reservation.checkout && !reservation.checkin
				if reserved
					if reservation.property.schedule_conflict?(DateTime.now.beginning_of_day, DateTime.now.end_of_day)
						return "reserved until #{reservation.property.end_date.strftime('%D')}"
					end
				end
			end
		end
		return "available"
	end

	# Create barcode based on unit `id`
	def unit_barcode(unit)
		return Barby::Code128.new(unit.id).to_svg(height: 40, margin: 0).html_safe
	end
end
