class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :trackable, polymorphic: true

  scope :by_date, -> { order("created_at DESC") }
end
