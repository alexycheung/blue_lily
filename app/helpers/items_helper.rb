module ItemsHelper
	# Return item photo or camera icon
	def item_photo(item)
		if item.photo
			return "#{filepicker_image_tag item.photo, fit: 'crop', w: 200, h: 200}"
		else
			return "#{fa_icon 'camera'}"
		end
	end

	# Create barcode based on item `id`
	def item_barcode(item)
		return Barby::Code128.new(item.id).to_svg(height: 40, margin: 0).html_safe
	end
end
