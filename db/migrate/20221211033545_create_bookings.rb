class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.datetime :starts_at
      t.datetime :ends_at
      t.references :user, null: false, foreign_key: true
      t.references :mole, null: false, foreign_key: true

      t.timestamps
    end
  end
end
