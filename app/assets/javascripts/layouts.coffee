$(document).ready ->
	window.wiselinks = new Wiselinks($('#yield-container'))

	if $('#sidebar')[0]
		$('html').on 'click', '#sidebar a', ->
			$('#sidebar a').removeClass 'active'
			$(this).addClass 'active'
			return

	$('html').on 'click', 'a[data-target="#yield-container"]', ->
		$('#yield-container').html '<div class="loader">Loading...</div>'
		return