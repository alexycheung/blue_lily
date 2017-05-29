class Item < ApplicationRecord
	validates :name, presence: true
	validates :color, presence: true
	validates :size, presence: true
	validates :condition, presence: true
	validates :purchase_price, presence: true
	validates :description, presence: true
	validates :company, presence: true
	validates :category_id, presence: true, numericality: true

	belongs_to :category
	has_many :reservations
	has_many :properties, through: :reservations

	scope :by_date, -> { order("created_at DESC") }

	# Return true if item is reserved on date
	def reserved?(start_date, end_date)
		item = self
		item.reservations.each do |reservation|
			property = reservation.property
			if (start_date - property.start_date) * (property.end_date - end_date) >= 0
				return true
			end
		end
		return false
	end

	# Return last reservation
	def last_reservation
		item = self
		last_reservation = nil
		if item.reservations.any?
			last_reservation = item.reservations.first
		end
		return last_reservation
	end

	# Return true if item is checked out under property
	def checked_out?(property)
		item = self
		if Reservation.where(property_id: property.id, item_id: item.id).where("checkout IS NOT NULL").any?
			return true
		end
		return false
	end

	# Return true if item is checked in under property
	def checked_in?(property)
		item = self
		if Reservation.where(property_id: property.id, item_id: item.id).where("checkin IS NOT NULL").any?
			return true
		end
		return false
	end
end
