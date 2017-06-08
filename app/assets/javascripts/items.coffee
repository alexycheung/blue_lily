# save filepicker photo to db
@onPhotoUpload = (event) ->
	 $(".upload-photo").html "<img src='"+event.fpfile.url+"/convert?fit=crop&h=187&w=187'>"

$(document).ready ->
	$('html').on 'click', '#close-overlay svg', ->
	  $('#overlay').remove()
	  return

	# Submit checkin / checkout form after barcode finishes scanning
	checkoutTimer = undefined
	doneTypingCheckoutInterval = 1000

	doneTypingCheckout = ->
	  $('#checkout-item')[0].submit()
	  return

	$('#checkout-item #item_id').keyup ->
	  clearTimeout checkoutTimer
	  if $('#checkout-item #item_id').val()
	    checkoutTimer = setTimeout(doneTypingCheckout, doneTypingCheckoutInterval)
	  return

	checkinTimer = undefined
	doneTypingCheckinInterval = 1000

	doneTypingCheckin = ->
	  $('#checkin-item')[0].submit()
	  return

	$('#checkin-item #item_id').keyup ->
	  clearTimeout checkinTimer
	  if $('#checkin-item #item_id').val()
	    checkinTimer = setTimeout(doneTypingCheckin, doneTypingCheckinInterval)
	  return