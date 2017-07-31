$(document).ready ->
	# format price fields as currency
	if $('#unit_purchase_price')[0]
		$('#unit_purchase_price').autoNumeric 'init'
	if $('#unit_sale_price')[0]
		$('#unit_sale_price').autoNumeric 'init'
