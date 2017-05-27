class Item < ApplicationRecord
	validates :name, presence: true
	validates :color, presence: true
	validates :size, presence: true
	validates :condition, presence: true
	validates :purchase_price, presence: true
	validates :description, presence: true
	validates :company, presence: true
	validates :category_id, presence: true, numericality: true

	belongs_to :category

	scope :by_date, -> { order("created_at DESC") }
end
