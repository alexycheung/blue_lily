module ItemsHelper
	# Return item photo or camera icon
	def item_photo(item)
		if item.photo
			return "#{filepicker_image_tag item.photo, fit: 'crop', w: 187, h: 187}"
		else
			return "#{fa_icon 'camera'}"
		end
	end
end
