module ItemsHelper
	# Return item photo or camera icon
	def item_photo(item)
		if item.photo && item.photo != ""
			return "#{filepicker_image_tag item.photo, fit: 'crop', w: 200, h: 200}"
		else
			return "#{fa_icon 'camera'}"
		end
	end
end
