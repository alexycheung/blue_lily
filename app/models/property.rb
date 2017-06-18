class Property < ApplicationRecord
	validates :address, presence: true
	validates :city, presence: true
	validates :state, presence: true
	validates :zip, presence: true
	validates :bedrooms, presence: true, numericality: true
	validates :bathrooms, presence: true, numericality: true
	validates :sqft, presence: true, numericality: true

	belongs_to :user, optional: true
	has_many :reservations
	has_many :items, through: :reservations
	has_many :photos

	scope :by_start_date, -> { order("start_date DESC") }
	scope :active, -> { where(destroyed_at: nil) }

	# Return true if updated start_date / end_date conflicts with item availability
	def schedule_conflict?(start_date, end_date)
		property = self
		property.items.active.each do |item|
			item.reservations.active.where.not(property_id: property.id).each do |reservation|
				if start_date >= reservation.property.start_date && start_date <= reservation.property.end_date
					return true
				elsif end_date >= reservation.property.start_date && end_date <= reservation.property.end_date
					return true
				elsif start_date <= reservation.property.start_date && end_date >= reservation.property.end_date
					return true
				end
			end
		end
		return false
	end

	def status
		property = self
		if !property.start_date || !property.end_date
			return nil
		elsif Date.today <= property.start_date
			return "upcoming"
		elsif Date.today <= property.end_date
			return "started"
		else
			return "ended"
		end
	end
end
