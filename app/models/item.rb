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

	scope :by_date, -> { order("created_at DESC") }
	scope :active, -> { where("destroyed_at IS NULL") }

	# Return last reservation
	def last_reservation
		item = self
		last_reservation = nil
		if item.reservations.active.any?
			last_reservation = item.reservations.active.first
		end
		return last_reservation
	end
end
