class Item < ApplicationRecord
	has_paper_trail ignore: [:updated_at]

	searchkick word_start: [:name, :vendor_item_number]

	validates :name, presence: true
	validates :color, presence: true
	validates :description, presence: true
	validates :category_id, presence: true, numericality: true
	validates :vendor_id, presence: true, numericality: true

	belongs_to :category
	belongs_to :vendor
	has_many :units
	has_many :reservations
	has_many :properties, through: :reservations

	scope :by_date, -> { order("created_at DESC") }
	scope :active, -> { where("destroyed_at IS NULL") }

	# Return property if item is reserved on date
	def reserved_for_property(start_date, end_date)
		item = self
		item.reservations.active.each do |reservation|
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

	# Return last reservation
	def last_reservation
		item = self
		last_reservation = nil
		if item.reservations.active.any?
			last_reservation = item.reservations.active.first
		end
		return last_reservation
	end

	# Return true if item is reserved for property
	def is_reserved?(property)
		item = self
		if item.reservations.active.where(property_id: property.id).any?
			return true
		end
		return false
	end

	# Return reservation for item / property
	def item_reservation(property)
		item = self
		if item.reservations.active.where(property_id: property.id).any?
			return reservation = item.reservations.active.where(property_id: property.id).first
		end
		return nil
	end
end
