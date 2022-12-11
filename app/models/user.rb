class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bookings
  has_many :moles
  has_many :rented_moles, through: :bookings, source: :mole
end
