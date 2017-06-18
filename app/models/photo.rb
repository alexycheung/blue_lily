class Photo < ApplicationRecord
	validates :url, presence: true
	validates :property_id, presence: true, numericality: true

	belongs_to :property

	scope :active, -> { where(destroyed_at: nil) }
	scope :by_date, -> { order("created_at DESC") }
end
