# show filepicker photo on successful upload
@onPhotoUpload = (event) ->
	 $(".upload-photo").html "<img src='"+event.fpfile.url+"/convert?fit=crop&h=200&w=200'>"

$(document).ready ->
	$('html').on 'click', '#close-overlay svg', ->
	  $('#overlay').remove()
	  return