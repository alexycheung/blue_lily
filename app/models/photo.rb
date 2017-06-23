class Photo < ApplicationRecord
	has_paper_trail ignore: [:updated_at]

	validates :url, presence: true
	validates :property_id, presence: true, numericality: true

	belongs_to :property

	scope :by_date, -> { order("created_at DESC") }
	scope :active, -> { where("destroyed_at IS NULL") }
end
