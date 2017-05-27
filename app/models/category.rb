class Category < ApplicationRecord
	validates :name, presence: true

	has_many :items

	scope :by_date, -> { order("created_at DESC") }
end
