class Property < ApplicationRecord
	validates :address, presence: true
	validates :city, presence: true
	validates :state, presence: true
	validates :zip, presence: true
	validates :start_date, presence: true
	validates :end_date, presence: true
	validates :bedrooms, presence: true, numericality: true
	validates :bathrooms, presence: true, numericality: true
	validates :sqft, presence: true, numericality: true
	validates :price, presence: true, numericality: true
	validates :deposit, presence: true, numericality: true
	validates :user_id, presence: true

	belongs_to :user
	has_many :reservations
	has_many :items, through: :reservations

	scope :by_start_date, -> { order("start_date DESC") }

	# Return true if updated start_date / end_date conflicts with item availability
	def schedule_conflict?(start_date, end_date)
		property = self
		property.items.each do |item|
			item.reservations.where.not(property_id: property.id).each do |reservation|
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
end
