$(document).on 'turbolinks:load', ->
	if $("#property_start_date")[0]
		$("#property_start_date").datepicker()
	if $("#property_end_date")[0]
		$("#property_end_date").datepicker()
	return