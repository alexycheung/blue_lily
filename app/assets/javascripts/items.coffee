# save filepicker photo to db
@onPhotoUpload = (event) ->
	 $(".upload-photo").html "<img src='"+event.fpfile.url+"/convert?fit=crop&h=187&w=187'>"

$(document).ready ->
	$('html').on 'click', '#close-overlay svg', ->
	  $('#overlay').remove()
	  return