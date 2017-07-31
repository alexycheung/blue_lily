class Unit < ApplicationRecord
	has_paper_trail ignore: [:updated_at]
	
	validates :item_id, presence: true, numericality: true
	validates :condition, presence: true
	validates :purchase_price, presence: true, numericality: true

	belongs_to :item

	scope :by_date, -> { order("created_at DESC") }
	scope :active, -> { where("destroyed_at IS NULL") }
end
