# show filepicker photo on successful upload
@onItemPhotoUpload = (event) ->
	$(".upload-photo").html "<img src='"+event.fpfile.url+"/convert?fit=crop&h=200&w=200'>"

$(document).ready ->
	if $('#item_purchase_price')[0]
		$('#item_purchase_price').autoNumeric 'init'
	if $('#item_sale_price')[0]
		$('#item_sale_price').autoNumeric 'init'

	$('html').on 'click', '#close-overlay svg', ->
		$('#overlay').remove()
		return
