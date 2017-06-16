class Reservation < ApplicationRecord
	belongs_to :item
	belongs_to :property

	scope :by_checkout, -> { order("checkout DESC") }
	scope :active, -> { where(destroyed_at: nil) }
end
