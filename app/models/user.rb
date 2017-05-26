class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true
  validates :phone, presence: true
  validates :company, presence: true

  has_many :properties

  scope :by_date, -> { order("created_at DESC") }
end

