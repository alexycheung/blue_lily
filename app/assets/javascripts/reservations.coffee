$(document).ready ->
	# Submit checkin / checkout form after barcode finishes scanning
	checkoutTimer = undefined
	doneTypingCheckoutInterval = 1000

	doneTypingCheckout = ->
	  $('#checkout-item')[0].submit()
	  return

	if $('#checkout-item')[0]
		$('#item_id').keyup ->
		  clearTimeout checkoutTimer
		  if $('#item_id').val()
		    checkoutTimer = setTimeout(doneTypingCheckout, doneTypingCheckoutInterval)
		  return

	checkinTimer = undefined
	doneTypingCheckinInterval = 1000

	doneTypingCheckin = ->
	  $('#checkin-item')[0].submit()
	  return

	if $('#checkin-item')[0]
		$('#item_id').keyup ->
		  clearTimeout checkinTimer
		  if $('#item_id').val()
		    checkinTimer = setTimeout(doneTypingCheckin, doneTypingCheckinInterval)
		  return