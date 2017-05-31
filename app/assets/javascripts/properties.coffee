$(document).ready ->
	# Display property form
	$('html').on 'click', '#show-new-property-form', ->
		url = window.location.href
		window.location.href = url + "/?show_new_property_form=true"
		return

	# Initialize datepicker in property form
	if $("#property_start_date")[0]
		$("#property_start_date").datepicker()
	if $("#property_end_date")[0]
		$("#property_end_date").datepicker()
	return