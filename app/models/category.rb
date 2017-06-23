class Category < ApplicationRecord
	has_paper_trail ignore: [:updated_at]

	validates :name, presence: true

	has_many :items

	scope :by_date, -> { order("created_at DESC") }
	scope :active, -> { where("destroyed_at IS NULL") }
end
