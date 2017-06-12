class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true
  validates :phone, presence: true
  validates :company, presence: true

  has_many :activities
  has_many :properties

  scope :by_date, -> { order("created_at DESC") }
  scope :agents, -> { where(role: "agent") }
  scope :active, -> { where(destroyed_at: nil) }

  def is_super_admin?
    user = self
    return true if user.role == "super admin"
    return false
  end

  def is_admin?
    user = self
    return true if user.role == "admin"
    return false
  end

  def is_agent?
    user = self
    return true if user.role == "agent"
    return false
  end

  def is_mover?
    user = self
    return true if user.role == "mover"
    return false
  end
end

