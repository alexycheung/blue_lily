class Unit < ApplicationRecord
	has_paper_trail ignore: [:updated_at]
	
	validates :item_id, presence: true, numericality: true
	validates :condition, presence: true
	validates :purchase_price, presence: true, numericality: true

	belongs_to :item
	has_many :reservations
	has_many :properties, through: :reservations

	scope :by_date, -> { order("created_at DESC") }
	scope :active, -> { where("destroyed_at IS NULL") }

	# Return property if unit is reserved on date
	def reserved_for_property(start_date, end_date)
		unit = self
		unit.reservations.active.each do |reservation|
			property = reservation.property
			if start_date >= property.start_date && start_date <= property.end_date
				return property
			elsif end_date >= property.start_date && end_date <= property.end_date
				return property
			elsif start_date <= property.start_date && end_date >= property.end_date
				return property
			end
		end
		return nil
	end

	# Return true if unit is reserved for property
	def is_reserved?(property)
		unit = self
		if unit.reservations.active.where(property_id: property.id).any?
			return true
		end
		return false
	end

	# Return reservation for unit / property
	def unit_reservation(property)
		unit = self
		if unit.reservations.active.where(property_id: property.id).any?
			return reservation = unit.reservations.active.where(property_id: property.id).first
		end
		return nil
	end
end
