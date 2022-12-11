class Mole < ApplicationRecord
  has_many :bookings
  belongs_to :user
  has_many :users, through: :bookings

  enum shade: {
    mole: 0
  }
end
