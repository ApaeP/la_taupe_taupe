class Mole < ApplicationRecord
  has_many :bookings
  belongs_to :user
  has_many :users, through: :bookings

  enum shade: {
    mole: 0
  }

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def owner_full_name
    "#{user.first_name.capitalize} #{user.last_name.capitalize}"
  end
end
