class Version < ApplicationRecord
	scope :by_date, -> { order("created_at DESC") }

	def undo
		version = self
		if version.item_type == "Category"
			category = Category.find_by_id(version.item_id)
			if version.event == "create"
				category.update_attributes(destroyed_at: DateTime.now)
			elsif version.event == "update"
				changeset = category.versions.find(version.id).changeset
				if changeset["destroyed_at"]
					if changeset["destroyed_at"][0]
						category.update_attributes(destroyed_at: DateTime.now)
					else
						category.update_attributes(destroyed_at: nil)
					end
				else
					changeset.to_a.each do |change|
						field = change[0]
						old_value = change[1][0]
						category[field] = old_value
					end
					category.save
				end
			end
		elsif version.item_type == "User"
			user = User.find(version.item_id)
			if version.event == "create"
				user.update_attributes(destroyed_at: DateTime.now)
			elsif version.event == "update"
				changeset = user.versions.find(version.id).changeset
				if changeset["destroyed_at"]
					if changeset["destroyed_at"][0]
						user.update_attributes(destroyed_at: DateTime.now)
					else
						user.update_attributes(destroyed_at: nil)
					end
				else
					changeset.to_a.each do |change|
						field = change[0]
						old_value = change[1][0]
						user[field] = old_value
					end
					user.save
				end
			end
		elsif version.item_type == "Property"
			property = Property.find(version.item_id)
			if version.event == "create"
				property.update_attributes(destroyed_at: DateTime.now)
			elsif version.event == "update"
				changeset = property.versions.find(version.id).changeset
				if changeset["destroyed_at"]
					if changeset["destroyed_at"][0]
						property.update_attributes(destroyed_at: DateTime.now)
					else
						property.update_attributes(destroyed_at: nil)
					end
				else
					changeset.to_a.each do |change|
						field = change[0]
						old_value = change[1][0]
						property[field] = old_value
					end
					property.save
				end
			end
		elsif version.item_type == "Item"
			item = Item.find(version.item_id)
			if version.event == "create"
				item.update_attributes(destroyed_at: DateTime.now)
			elsif version.event == "update"
				changeset = item.versions.find(version.id).changeset
				if changeset["destroyed_at"]
					if changeset["destroyed_at"][0]
						item.update_attributes(destroyed_at: DateTime.now)
					else
						item.update_attributes(destroyed_at: nil)
					end
				else
					changeset.to_a.each do |change|
						field = change[0]
						old_value = change[1][0]
						item[field] = old_value
					end
					item.save
				end
			end
		elsif version.item_type == "Photo"
			photo = Photo.find(version.item_id)
			if version.event == "create"
				photo.update_attributes(destroyed_at: DateTime.now)
			elsif version.event == "update"
				changeset = photo.versions.find(version.id).changeset
				if changeset["destroyed_at"]
					if changeset["destroyed_at"][0]
						photo.update_attributes(destroyed_at: DateTime.now)
					else
						photo.update_attributes(destroyed_at: nil)
					end
				end
			end
		elsif version.item_type == "Vendor"
			vendor = Vendor.find(version.item_id)
			if version.event == "create"
				vendor.update_attributes(destroyed_at: DateTime.now)
			elsif version.event == "update"
				changeset = vendor.versions.find(version.id).changeset
				if changeset["destroyed_at"]
					if changeset["destroyed_at"][0]
						vendor.update_attributes(destroyed_at: DateTime.now)
					else
						vendor.update_attributes(destroyed_at: nil)
					end
				else
					changeset.to_a.each do |change|
						field = change[0]
						old_value = change[1][0]
						vendor[field] = old_value
					end
					vendor.save
				end
			end
		elsif version.item_type == "Reservation"
			reservation = Reservation.find(version.item_id)
			if version.event == "create"
				reservation.update_attributes(destroyed_at: DateTime.now)
			elsif version.event == "update"
				changeset = reservation.versions.find(version.id).changeset
				if changeset["destroyed_at"]
					if changeset["destroyed_at"][0]
						reservation.update_attributes(destroyed_at: DateTime.now)
					else
						reservation.update_attributes(destroyed_at: nil)
					end
				else
					changeset.to_a.each do |change|
						field = change[0]
						old_value = change[1][0]
						reservation[field] = old_value
					end
					reservation.save
				end
			end
		end
	end

	def is_undone?
		version = self
		return true if version.undo_at
		return false
	end
end
