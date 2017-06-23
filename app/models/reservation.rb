class Reservation < ApplicationRecord
	has_paper_trail ignore: [:updated_at]

	belongs_to :item
	belongs_to :property

	scope :by_checkout, -> { order("checkout DESC") }
	scope :active, -> { where("destroyed_at IS NULL") }
end
