class Vendor < ApplicationRecord
	has_paper_trail ignore: [:updated_at]
	
	validates :name, presence: true

	has_many :items

	scope :active, -> { where("destroyed_at IS NULL") }
	scope :by_name, -> { order("name asc") }
end
