module VersionsHelper
	def formatted_version_item(version)
		if version.item_type == "Category"
			category = Category.find(version.item_id)
			if version.event == "create"
				return "created category <b>#{category.name}</b>".html_safe
			elsif version.event == "update"
				changeset = category.versions.find(version.id).changeset
				if changeset["destroyed_at"]
					if changeset["destroyed_at"][0]
						return "restored category <b>#{category.name}</b>".html_safe
					else
						return "destroyed category <b>#{category.name}</b>".html_safe
					end
				else
					updated_fields = "updated "
					changeset.to_a.each_with_index do |change, index|
						field = change[0]
						old_value = change[1][0]
						new_value = change[1][1]
						unless [nil, ""].include?(old_value) && [nil, ""].include?(new_value)
							updated_fields += ", " if index != 0
							updated_fields += "category #{field} from <b>#{old_value}</b> to <b>#{new_value}</b>"
						end
					end
					return updated_fields.html_safe
				end
			end
		elsif version.item_type == "User"
			user = User.find(version.item_id)
			if version.event == "create"
				return "created user <b>#{user.name}</b>".html_safe
			elsif version.event == "update"
				changeset = user.versions.find(version.id).changeset
				if changeset["destroyed_at"]
					if changeset["destroyed_at"][0]
						return "restored user <b>#{user.name}</b>".html_safe
					else
						return "destroyed user <b>#{user.name}</b>".html_safe
					end
				else
					updated_fields = "updated "
					changeset.to_a.each_with_index do |change, index|
						field = change[0]
						old_value = change[1][0]
						new_value = change[1][1]
						unless [nil, ""].include?(old_value) && [nil, ""].include?(new_value)
							updated_fields += ", " if index != 0
							updated_fields += "user #{field} from <b>#{old_value}</b> to <b>#{new_value}</b>"
						end
					end
					return updated_fields.html_safe
				end
			end
		elsif version.item_type == "Property"
			property = Property.find(version.item_id)
			if version.event == "create"
				return "created property <b>#{property.address}, #{property.city}</b>".html_safe
			elsif version.event == "update"
				changeset = property.versions.find(version.id).changeset
				if changeset["destroyed_at"]
					if changeset["destroyed_at"][0]
						return "restored property <b>#{property.address}, #{property.city}</b>".html_safe
					else
						return "destroyed porperty <b>#{property.address}, #{property.city}</b>".html_safe
					end
				else
					updated_fields = "updated "
					changeset.to_a.each_with_index do |change, index|
						field = change[0]
						old_value = change[1][0]
						new_value = change[1][1]
						unless [nil, ""].include?(old_value) && [nil, ""].include?(new_value)
							updated_fields += ", " if index != 0
							updated_fields += "property #{field} from <b>#{old_value ? old_value : 'nil'}</b> to <b>#{new_value ? new_value : 'nil'}</b>"
						end
					end
					return updated_fields.html_safe
				end
			end
		elsif version.item_type == "Item"
			item = Item.find(version.item_id)
			if version.event == "create"
				return "created item <b>#{item.name}</b>".html_safe
			elsif version.event == "update"
				changeset = item.versions.find(version.id).changeset
				if changeset["destroyed_at"]
					if changeset["destroyed_at"][0]
						return "restored item <b>#{item.name}</b>".html_safe
					else
						return "destroyed item <b>#{item.name}</b>".html_safe
					end
				else
					updated_fields = "updated "
					changeset.to_a.each_with_index do |change, index|
						field = change[0]
						old_value = change[1][0]
						new_value = change[1][1]
						unless [nil, ""].include?(old_value) && [nil, ""].include?(new_value)
							updated_fields += ", " if index != 0
							updated_fields += "item #{field} from <b>#{old_value ? old_value : 'nil'}</b> to <b>#{new_value ? new_value : 'nil'}</b>"
						end
					end
					return updated_fields.html_safe
				end
			end
		elsif version.item_type == "Photo"
			photo = Photo.find(version.item_id)
			if version.event == "create"
				return "created photo <b>#{photo.url}</b>".html_safe
			elsif version.event == "update"
				changeset = photo.versions.find(version.id).changeset
				if changeset["destroyed_at"]
					if changeset["destroyed_at"][0]
						return "restored photo <b>#{photo.url}</b>".html_safe
					else
						return "destroyed photo <b>#{photo.url}</b>".html_safe
					end
				end
			end
		elsif version.item_type == "Reservation"
			reservation = Reservation.find(version.item_id)
			item = reservation.item
			property = reservation.property
			if version.event == "create"
				return "created reservation for item <b>#{item.name}</b> at property <b>#{property.address}, #{property.city}</b>".html_safe
			elsif version.event == "update"
				changeset = reservation.versions.find(version.id).changeset
				if changeset["destroyed_at"]
					if changeset["destroyed_at"][0]
						return "restored reservation for item <b>#{item.name}</b> at property <b>#{property.address}, #{property.city}</b>".html_safe
					else
						return "destroyed reservation for item <b>#{item.name}</b> at property <b>#{property.address}, #{property.city}</b>".html_safe
					end
				else
					updated_fields = "updated reservation for item <b>#{item.name}</b> at property <b>#{property.address}, #{property.city}</b>: "
					changeset.to_a.each_with_index do |change, index|
						field = change[0]
						old_value = change[1][0]
						new_value = change[1][1]
						unless [nil, ""].include?(old_value) && [nil, ""].include?(new_value)
							updated_fields += ", " if index != 0
							updated_fields += "#{field} from <b>#{old_value ? old_value : 'nil'}</b> to <b>#{new_value ? new_value : 'nil'}</b>"
						end
					end
					return updated_fields.html_safe
				end
			end
		end
	end
end
