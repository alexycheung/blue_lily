# show property payment on successful upload
@onPropertyPaymentUpload = (event) ->
	$(".upload-payment").html "<img src='"+event.fpfile.url+"/convert?fit=crop&h=200&w=200'>"
	if $('#view_payment')[0]
		$('#view_payment')[0].remove()
	$('.payment-input').prepend('<a target="_blank" class="pure-button" id="view_payment" href="'+event.fpfile.url+'">View</a>')

# show property contract on successful upload
@onPropertyContractUpload = (event) ->
	$(".upload-contract").html "<img src='"+event.fpfile.url+"/convert?fit=crop&h=200&w=200'>"
	if $('#view_contract')[0]
		$('#view_contract')[0].remove()
	$('.contract-input').prepend('<a target="_blank" class="pure-button" id="view_contract" href="'+event.fpfile.url+'">View</a>')

$(document).ready ->
	# Update property end date when start date changes
	$('#property_start_date').on 'keyup change', ->
		start_date = $(this).val().split('/')
		start_date = new Date(start_date[2], start_date[0], start_date[1])
		end_date = new Date()
		end_date.setDate(start_date.getDate() + 90)
		end_date = (end_date.getMonth() + 1) + '/' + end_date.getDate() + '/' +  end_date.getFullYear()
		$('#property_end_date').val end_date
		return

	# Initialize datepicker in property form
	if $("#property_start_date")[0]
		$("#property_start_date").datepicker()
	if $("#property_end_date")[0]
		$("#property_end_date").datepicker()
	return