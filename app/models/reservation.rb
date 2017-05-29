class Reservation < ApplicationRecord
	belongs_to :item
	belongs_to :property

	scope :by_date, -> { order("created_at DESC") }
end
