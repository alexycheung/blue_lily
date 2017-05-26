class Property < ApplicationRecord
	belongs_to :user

	validates :address, presence: true
	validates :city, presence: true
	validates :state, presence: true
	validates :zip, presence: true
	validates :start_date, presence: true
	validates :end_date, presence: true
	validates :bedrooms, presence: true, numericality: true
	validates :bathrooms, presence: true, numericality: true
	validates :sqft, presence: true, numericality: true
	validates :price, presence: true, numericality: true
	validates :deposit, presence: true, numericality: true
	validates :user_id, presence: true

	scope :by_start_date, -> { order("start_date DESC") }
end
